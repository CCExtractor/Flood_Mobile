import 'dart:convert';

import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:json_patch/json_patch.dart';
import 'package:provider/provider.dart';

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
    //Setting the full list of torrent
    Provider.of<HomeProvider>(context, listen: false)
        .setTorrentList(torrentList);
  }
}
