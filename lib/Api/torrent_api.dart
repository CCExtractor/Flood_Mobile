import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'api.dart';

class TorrentApi {
  // Gets list of torrents
  static Stream<List<TorrentModel>> getAllTorrents(
      {BuildContext context}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
        Response response;
        Dio dio = new Dio();
        String url = Api.baseUrl + Api.getTorrentList;
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            Provider.of<UserDetailProvider>(context, listen: false).token;
        response = await dio.get(url);
        List<TorrentModel> torrentList = <TorrentModel>[];
        for (var hash in response.data['torrents'].keys) {
          try {
            TorrentModel torrentModel =
                TorrentModel.fromJson(response.data['torrents'][hash]);
            torrentList.add(torrentModel);
          } catch (e) {
            print(e.toString());
          }
        }
        yield torrentList;
      } catch (e) {
        print('Exception caught in Api Request ' + e.toString());
        yield [];
      }
      await Future.delayed(Duration(seconds: 1), () {});
    }
  }

  static Future<void> startTorrent(
      {List<String> hashes, BuildContext context}) async {
    try {
      String url = Api.baseUrl + Api.startTorrent;
      print('---START TORRENT---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> stopTorrent(
      {List<String> hashes, BuildContext context}) async {
    try {
      String url = Api.baseUrl + Api.stopTorrent;
      print('---STOP TORRENT---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
