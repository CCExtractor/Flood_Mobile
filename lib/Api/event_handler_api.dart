import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:duration/duration.dart';
import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:json_patch/json_patch.dart';
import 'package:provider/provider.dart';
import '../Constants/notification_keys.dart';
import '../Provider/filter_provider.dart';

String torrentLength = '';

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
    Provider.of<HomeProvider>(context, listen: false)
        .setSpeed(upSpeed, downSpeed);
  }

  //Getting full list of torrents
  static void setFullTorrentList({
    required SSEModel model,
    required BuildContext context,
  }) {
    Map<String, dynamic> data = json.decode(model.data ?? '');
    if (data.isNotEmpty) {
      //Storing the full list of torrent is string to use it through PATCH
      Provider.of<HomeProvider>(context, listen: false)
          .setTorrentListJson(data);
      print('---SET FULL TORRENT LIST---');
      List<TorrentModel> torrentList = <TorrentModel>[];
      for (var hash in data.keys) {
        try {
          TorrentModel torrentModel = TorrentModel.fromJson(data[hash]);
          torrentList.add(torrentModel);
        } catch (e) {
          print(e.toString());
        }
      }
      //Setting the full list of torrent
      Provider.of<HomeProvider>(context, listen: false)
          .setTorrentList(torrentList);
      filterDataRephrasor(torrentList, context);
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
      Provider.of<HomeProvider>(context, listen: false)
          .setUnreadNotifications(data['unread']);
    }
  }

  //Updating the full list of torrent
  static void updateFullTorrentList({
    required SSEModel model,
    required BuildContext context,
  }) {
    Map<String, dynamic> oldTorrentList =
        Provider.of<HomeProvider>(context, listen: false).torrentListJson;

    //Parsing the patch in list<map<String, dynamic> format
    List<Map<String, dynamic>> newTorrentMap = [];
    List<dynamic> patchList = json.decode(model.data ?? '');
    for (var i in patchList) {
      newTorrentMap.add(i);
    }

    //Applying patch
    final newTorrentList = JsonPatch.apply(
      oldTorrentList,
      newTorrentMap,
      strict: true,
    );

    //Updating data in provider
    Provider.of<HomeProvider>(context, listen: false)
        .setTorrentListJson(newTorrentList);
    print('---UPDATE TORRENT LIST---');
    List<TorrentModel> torrentList = <TorrentModel>[];
    for (var hash in newTorrentList.keys) {
      try {
        TorrentModel torrentModel = TorrentModel.fromJson(newTorrentList[hash]);
        torrentList.add(torrentModel);
      } catch (e) {
        print(e.toString());
      }
    }

    if (torrentList.length > int.parse(torrentLength) ||
        torrentList.length < int.parse(torrentLength)) {
      filterDataRephrasor(torrentList, context);
    }

    //Setting the full list of torrent
    Provider.of<HomeProvider>(context, listen: false)
        .setTorrentList(torrentList);
  }

  static Future<void> showNotification(int id, BuildContext context) async {
    late bool displayNotification;
    late bool isPaused;
    isPaused = true;
    HomeProvider homeModel = Provider.of<HomeProvider>(context, listen: false);

    // Skip finished torrents
    if (homeModel.torrentList[id].status.contains('complete')) {
      displayNotification = false;
    } else {
      displayNotification = true;
    }

    // Torrent not being downloaded
    if (homeModel.torrentList[id].status.contains('downloading')) {
      // Change to the 'RESUME' action
      isPaused = false;
    }

    // Torrent Paused
    else {
      isPaused = true;
    }

    // Create notification for unfinished downloads
    if (displayNotification) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          actionType: ActionType.Default,
          channelKey: NotificationConstants.DOWNLOADS_CHANNEL_KEY,
          category: NotificationCategory.Progress,
          notificationLayout: NotificationLayout.ProgressBar,
          title: homeModel.torrentList[id].name,
          body: isPaused
              ? "Stopped ETA: ∞"
              : "Downloading ETA: " +
                  prettyDuration(
                    Duration(
                      seconds: homeModel.torrentList[id].eta.toInt(),
                    ),
                    abbreviated: true,
                  ),
          progress: homeModel.torrentList[id].percentComplete.round(),
          summary: isPaused ? 'Paused' : 'Downloading',
          locked: true,
          autoDismissible: false,
          showWhen: false,
        ),
        actionButtons: [
          NotificationActionButton(
            key: isPaused
                ? NotificationConstants.RESUME_ACTION_KEY
                : NotificationConstants.PAUSE_ACTION_KEY,
            label: isPaused ? 'Resume' : 'Pause',
            actionType: ActionType.KeepOnTop,
            enabled: true,
            autoDismissible: false,
          ),
        ],
      );
    }
  }

  static Future<void> showEventNotification(
      int id, BuildContext context) async {
    HomeProvider homeModel = Provider.of<HomeProvider>(context, listen: false);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id,
      autoDismissible: false,
      channelKey: NotificationConstants.PUSH_NOTIFICATION_CHANNEL_KEY,
      category: NotificationCategory.Event,
      notificationLayout: NotificationLayout.Default,
      title: homeModel.torrentList[id].name,
      body: "Download Finished",
    ));
  }

  static Future<void> filterDataRephrasor(
      List<TorrentModel> torrentList, context) async {
    var maptrackerURIs = {};
    var mapStatus = {};
    List<String> statusList = [];
    torrentLength = torrentList.length.toString();
    try {
      for (int i = 0; i < torrentList.length; i++) {
        for (int j = 0; j < torrentList[i].trackerURIs.length; j++) {
          Provider.of<FilterProvider>(context, listen: false)
              .trackerURIsListMain
              .add(torrentList[i].trackerURIs[j].toString());
          Provider.of<FilterProvider>(context, listen: false)
              .settrackerURIsListMain(
                  Provider.of<FilterProvider>(context, listen: false)
                      .trackerURIsListMain);
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      Provider.of<FilterProvider>(context, listen: false)
          .trackerURIsListMain
          .forEach((element) {
        if (!maptrackerURIs.containsKey(element)) {
          maptrackerURIs[element] = 1;
        } else {
          maptrackerURIs[element] += 1;
        }
      });
      Provider.of<FilterProvider>(context, listen: false)
          .setmaptrackerURIs(maptrackerURIs);
    } catch (e) {
      print(e);
    }
    try {
      for (int i = 0; i < torrentList.length; i++) {
        for (int j = 0; j < torrentList[i].status.length; j++) {
          statusList.add(torrentList[i].status[j].toString());
        }
      }
      Provider.of<FilterProvider>(context, listen: false)
          .setstatusList(statusList);
    } catch (e) {
      print(e);
    }

    try {
      statusList.forEach((element) {
        if (!mapStatus.containsKey(element)) {
          mapStatus[element] = 1;
        } else {
          mapStatus[element] += 1;
        }
      });
      Provider.of<FilterProvider>(context, listen: false)
          .setmapStatus(mapStatus);
    } catch (error) {
      print(error);
    }
  }
}
