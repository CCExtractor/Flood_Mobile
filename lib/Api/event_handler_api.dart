import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:json_patch/json_patch.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/power_management_bloc/power_management_bloc.dart';
import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';

String torrentLength = '0';

class EventHandlerApi {
  //Sets the transfer rate if the event returned is TRANSFER_SUMMARY_FULL_UPDATE
  static void setTransferRate({
    required SSEModel model,
    required BuildContext context,
  }) {
    dynamic data = json.decode(model.data ?? '');
    RateModel rateModel = RateModel.fromJson(data);
    String downSpeed = filesize(rateModel.downRate.toString());
    String upSpeed = filesize(rateModel.upRate.toString());
    BlocProvider.of<HomeScreenBloc>(context, listen: false)
        .add(SetSpeedEvent(up: upSpeed, down: downSpeed));
  }

  //Getting full list of torrents
  static void setFullTorrentList({
    required SSEModel model,
    required BuildContext context,
  }) {
    Map<String, dynamic> data = json.decode(model.data ?? '');
    if (data.isNotEmpty) {
      //Storing the full list of torrent is string to use it through PATCH
      BlocProvider.of<HomeScreenBloc>(context, listen: false)
          .add(SetTorrentListJsonEvent(newTorrentListJson: data));
      print('---SET FULL TORRENT LIST---');
      List<TorrentModel> newTorrentList = <TorrentModel>[];
      for (var hash in data.keys) {
        try {
          TorrentModel torrentModel = TorrentModel.fromJson(data[hash]);
          newTorrentList.add(torrentModel);
        } catch (error) {
          print(error.toString());
        }
      }
      //Setting the full list of torrent
      BlocProvider.of<HomeScreenBloc>(context, listen: false)
          .add(SetTorrentListEvent(newTorrentList: newTorrentList));
      filterDataRephrasor(newTorrentList, context);
    }
  }

  //Setting notification count
  static void setNotificationCount({
    required SSEModel model,
    required BuildContext context,
  }) {
    Map<String, dynamic> data = json.decode(model.data ?? '');
    if (data.isNotEmpty) {
      print('---SET UNREAD NOTIFICATION COUNT---');
      //Set unread notification count
      BlocProvider.of<HomeScreenBloc>(context, listen: false)
          .add(SetUnreadNotificationsEvent(count: data['unread']));
    }
  }

  //Updating the full list of torrent
  static Future<void> updateFullTorrentList({
    required SSEModel model,
    required BuildContext context,
  }) async {
    Map<String, dynamic> oldTorrentList =
        BlocProvider.of<HomeScreenBloc>(context, listen: false)
            .state
            .torrentListJson;

    //Parsing the patch in list<map<String, dynamic> format
    List<Map<String, dynamic>> newTorrentMap = [];
    List<dynamic> patchList = json.decode(model.data ?? '');
    for (var i in patchList) {
      newTorrentMap.add(i);
    }

    //Applying patch
    final newTorrentListJson = JsonPatch.apply(
      oldTorrentList,
      newTorrentMap,
      strict: true,
    );
    //Updating data in provider
    BlocProvider.of<HomeScreenBloc>(context, listen: false)
        .add(SetTorrentListJsonEvent(newTorrentListJson: newTorrentListJson));
    print('---UPDATE TORRENT LIST---');
    List<TorrentModel> torrentList = <TorrentModel>[];
    for (var hash in newTorrentListJson.keys) {
      try {
        TorrentModel torrentModel =
            TorrentModel.fromJson(newTorrentListJson[hash]);
        torrentModel.tags = torrentModel.tags.toSet().toList();
        if (torrentModel.status.contains('stopped') &&
            torrentModel.status.contains('downloading')) {
          torrentModel.status
              .removeWhere((element) => element.contains('downloading'));
        }
        torrentList.add(torrentModel);
      } catch (error) {
        print(error.toString());
      }
    }

    if (torrentList.length > int.parse(torrentLength) ||
        torrentList.length < int.parse(torrentLength)) {
      filterDataRephrasor(torrentList, context);
    }

    //Setting the full list of torrent
    BlocProvider.of<HomeScreenBloc>(context, listen: false)
        .add(SetTorrentListEvent(newTorrentList: torrentList));

    final PowerManagementBloc powerManagementBloc =
        BlocProvider.of<PowerManagementBloc>(context, listen: false);
    //Exit screen on all download finished
    if (powerManagementBloc.state.shutDownWhenFinishDownload &&
        isAllDownloadFinished(context)) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    }

    //Turn off wifi on all download finished
    if (powerManagementBloc.state.shutDownWifi &&
        isAllDownloadFinished(context)) {
      turnOffWiFi(powerManagementBloc.state.shutDownWifi);
    }

    // Stop all download on low battery
    Battery _battery = Battery();
    int currentBatteryLevel = await _battery.batteryLevel;
    bool isBatteryLimitSet =
        powerManagementBloc.state.batteryLimitLevel > 0 ? true : false;
    if (isBatteryLimitSet &&
        currentBatteryLevel <= powerManagementBloc.state.batteryLimitLevel) {
      BlocProvider.of<HomeScreenBloc>(context, listen: false)
          .state
          .torrentList
          .forEach((element) {
        if (element.status.contains('downloading')) {
          TorrentApi.stopTorrent(hashes: [element.hash], context: context);
        }
      });
    }
  }

  static Future<void> filterDataRephrasor(
      List<TorrentModel> torrentList, context) async {
    FilterTorrentBloc filterBloc =
        BlocProvider.of<FilterTorrentBloc>(context, listen: false);
    var maptrackerURIs = {};
    var mapStatus = {};
    List<String> statusList = [];
    Map<String, dynamic> mapTags = {};
    List<Map<String, dynamic>> trackersSizeList = [];
    List<Map<String, dynamic>> tagsSizeList = [];

    //For torrent trackerURI
    //make a List of Map for trackerURIs and their corresponding size
    try {
      for (int i = 0; i < torrentList.length; i++) {
        for (int j = 0; j < torrentList[i].trackerURIs.length; j++) {
          trackersSizeList.add({
            torrentList[i].trackerURIs[j].toString():
                torrentList[i].sizeBytes.toString()
          });
        }
      }
      filterBloc
          .add(SetTrackersSizeListEvent(trackersSizeList: trackersSizeList));
    } catch (error) {
      print(error);
    }
    //make a map of trackerURIs and their corresponding status
    try {
      filterBloc.state.trackersSizeList.forEach((element) {
        if (!maptrackerURIs.containsKey(element.keys.first)) {
          maptrackerURIs[element.keys.first] = [
            1,
            double.parse(element.values.first)
          ];
        } else {
          maptrackerURIs.update(
              element.keys.first,
              (value) => [
                    value[0] + 1,
                    value[1] + double.parse(element.values.first)
                  ]);
        }
      });
      maptrackerURIs = SplayTreeMap<String, dynamic>.from(maptrackerURIs);
      filterBloc.add(SetMapTrackerURIsEvent(maptrackerURIs: maptrackerURIs));
    } catch (error) {
      print(error);
    }

    //For torrent tags
    //make a List of Map for tags and their corresponding size
    try {
      for (int i = 0; i < torrentList.length; i++) {
        if (torrentList[i].tags.isEmpty) {
          tagsSizeList.add({'Untagged': '0'});
        } else {
          for (int j = 0; j < torrentList[i].tags.length; j++) {
            tagsSizeList.add({
              torrentList[i].tags[j].toString():
                  torrentList[i].sizeBytes.toString()
            });
          }
        }
      }
      filterBloc.add(SetTagsSizeListEvent(tagsSizeList: tagsSizeList));
    } catch (error) {
      print(error);
    }
    //make a map of tags and their corresponding status
    try {
      filterBloc.state.tagsSizeList.forEach((element) {
        if (!mapTags.containsKey(element.keys.first)) {
          mapTags[element.keys.first] = [1, double.parse(element.values.first)];
        } else {
          mapTags.update(
              element.keys.first,
              (value) => [
                    value[0] + 1,
                    value[1] + double.parse(element.values.first)
                  ]);
        }
      });
      mapTags = SplayTreeMap<String, dynamic>.from(mapTags);
      filterBloc.add(SetMapTagsEvent(mapTags: mapTags));
    } catch (error) {
      print(error);
    }

    //For torrent status
    try {
      for (int i = 0; i < torrentList.length; i++) {
        for (int j = 0; j < torrentList[i].status.length; j++) {
          statusList.add(torrentList[i].status[j].toString());
        }
      }
      filterBloc.add(SetStatusListEvent(statusList: statusList));
    } catch (error) {
      print(error);
    }

    try {
      statusList.forEach((element) {
        if (!mapStatus.containsKey(element)) {
          mapStatus[element] = 1;
        } else {
          mapStatus[element] += 1;
        }
      });
      filterBloc.add(SetMapStatusEvent(mapStatus: mapStatus));
    } catch (error) {
      print(error);
    }
  }
}

bool isAllDownloadFinished(BuildContext context) {
  return BlocProvider.of<HomeScreenBloc>(context, listen: false)
      .state
      .torrentList
      .every(
    (element) {
      return element.status.contains('complete');
    },
  );
}

void turnOffWiFi(bool wifiStatus) async {
  WiFiForIoTPlugin.setEnabled(!wifiStatus);
}
