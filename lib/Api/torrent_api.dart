import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/torrent_content_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Services/file_folder_nester.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';

class TorrentApi {
  // Gets list of torrents
  static Stream<List<TorrentModel>> getAllTorrents(
      {BuildContext context}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
        Response response;
        Dio dio = new Dio();
        String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
            ApiProvider.getTorrentListUrl;
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
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.startTorrentUrl;
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
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.stopTorrentUrl;
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

  static Future<void> addTorrentMagnet(
      {String magnetUrl,
      String destination,
      BuildContext context,
      bool isBasePath,
      bool isCompleted,
      bool isSequential}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addTorrentMagnet;
      print('---ADD TORRENT MAGNET---');
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
      mp['urls'] = [magnetUrl];
      mp['destination'] = destination;
      mp['isBasePath'] = isBasePath;
      mp['isCompleted'] = isCompleted;
      mp['isSequential'] = isSequential;
      mp['start'] = true;
      mp['tags'] = [];
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT ADDED--');
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> addTorrentFile(
      {String base64,
      String destination,
      BuildContext context,
      bool isBasePath,
      bool isSequential,
      bool isCompleted}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addTorrentFile;
      print('---ADD TORRENT FILE---');
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
      mp['files'] = [base64];
      mp['destination'] = destination;
      mp['isBasePath'] = isBasePath;
      mp['isCompleted'] = isCompleted;
      mp['isSequential'] = isSequential;
      mp['start'] = true;
      mp['tags'] = [];
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT ADDED--');
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> deleteTorrent(
      {String hash, bool deleteWithData, BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.deleteTorrent;
      print('---DELETE TORRENT---');
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
      mp['hashes'] = [hash];
      mp['deleteData'] = deleteWithData;
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT DELETED--');
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Stream<Map<String, dynamic>> getTorrentContent({
    BuildContext context,
    String hash,
  }) async* {
    while (true) {
      print('---GET TORRENT CONTENT---');
      await Future.delayed(Duration(milliseconds: 500));
      try {
        Response response;
        Dio dio = new Dio();
        String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
            ApiProvider.getTorrentContent +
            hash +
            '/contents';
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            Provider.of<UserDetailProvider>(context, listen: false).token;
        response = await dio.get(url);
        List<TorrentContentModel> torrentContentList = <TorrentContentModel>[];
        for (var data in response.data) {
          try {
            TorrentContentModel torrentContent =
                TorrentContentModel.fromJson(data);
            torrentContentList.add(torrentContent);
          } catch (e) {
            print(e.toString());
          }
        }
        Provider.of<TorrentContentProvider>(context, listen: false)
            .setTorrentContentList(torrentContentList);
        yield convertToFolder(torrentContentList);
      } catch (e) {
        print('Exception caught in Api Request ' + e.toString());
        yield {};
      }
      await Future.delayed(Duration(seconds: 2), () {});
    }
  }

  static Future<void> setTorrentContentPriority(
      {BuildContext context,
      String hash,
      int priorityType,
      List<int> indexList}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.setTorrentContentPriorityUrl +
          hash +
          '/contents';
      print('---SET TORRENT PRIORITY---');
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
      mp['indices'] = indexList;
      mp['priority'] = priorityType;
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio.patch(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print(response);
        print('--PRIORITY SET--');
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> checkTorrentHash(
      {List<String> hashes, BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.checkHash;
      print('---CHECK TORRENT HASH---');
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
