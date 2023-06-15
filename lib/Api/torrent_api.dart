import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Services/file_folder_nester.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/user_detail_bloc/user_detail_bloc.dart';

class TorrentApi {
  // Gets list of torrents
  static Stream<List<TorrentModel>> getAllTorrents(
      {required BuildContext context}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
        Response response;
        Dio dio = new Dio();
        String url =
            BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
                ApiEndpoints.getTorrentListUrl;
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            BlocProvider.of<UserDetailBloc>(context, listen: false).token;
        response = await dio.get(url);
        List<TorrentModel> torrentList = <TorrentModel>[];
        for (var hash in response.data['torrents'].keys) {
          try {
            TorrentModel torrentModel =
                TorrentModel.fromJson(response.data['torrents'][hash]);
            torrentList.add(torrentModel);
          } catch (error) {
            print('--ERROR IN GET ALL TORRENTS LIST--');
            print(error.toString());
          }
        }
        yield torrentList;
      } catch (error) {
        print('--ERROR IN GET ALL TORRENTS LIST--' + error.toString());
        yield [];
      }
      await Future.delayed(Duration(seconds: 1), () {});
    }
  }

  static Future<void> startTorrent(
      {required List<String> hashes, required BuildContext context}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.startTorrentUrl;
      print('---START TORRENT---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT STARTED--');
      }
    } catch (error) {
      print('--ERROR IN TORRENT START--');
      print(error.toString());
    }
  }

  static Future<void> stopTorrent(
      {required List<String> hashes, required BuildContext context}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.stopTorrentUrl;
      print('---STOP TORRENT---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT STOPPED--');
      }
    } catch (error) {
      print('--ERROR IN TORRENT STOP--');
      print(error.toString());
    }
  }

  static Future<void> addTorrentMagnet({
    required String magnetUrl,
    required String destination,
    required BuildContext context,
    required bool isBasePath,
    required bool isCompleted,
    required bool isSequential,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.addTorrentMagnet;
      print('---ADD TORRENT MAGNET---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
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
        print('--TORRENT MEGNET ADDED--');
      }
    } catch (error) {
      print('--ERROR IN ADD TORRENT MEGNET--');
      print(error.toString());
    }
  }

  static Future<void> addTorrentFile({
    required String base64,
    required String destination,
    required BuildContext context,
    required bool isBasePath,
    required bool isSequential,
    required bool isCompleted,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.addTorrentFile;
      print('---ADD TORRENT FILE---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
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
        print('--TORRENT FILE ADDED--');
      }
    } catch (error) {
      print('--ERROR IN ADD TORRENT FILE--');
      print(error.toString());
    }
  }

  static Future<void> deleteTorrent({
    required List<int> id,
    required List<String> hashes,
    required bool deleteWithData,
    required BuildContext context,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.deleteTorrent;
      print('---DELETE TORRENT---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      mp['deleteData'] = deleteWithData;
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TORRENT DELETED--');
        id.forEach((element) {
          AwesomeNotifications().dismiss(element);
        });
      }
    } catch (error) {
      print('--ERROR IN TORRENT DELETE--');
      print(error.toString());
    }
  }

  static Stream<Map<String, dynamic>> getTorrentContent({
    required BuildContext context,
    required String hash,
  }) async* {
    while (true) {
      print('---GET TORRENT CONTENT---');
      await Future.delayed(Duration(milliseconds: 500));
      try {
        Response response;
        Dio dio = new Dio();
        String url =
            BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
                ApiEndpoints.getTorrentContent +
                hash +
                '/contents';
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            BlocProvider.of<UserDetailBloc>(context, listen: false).token;
        response = await dio.get(url);
        List<TorrentContentModel> torrentContentList = <TorrentContentModel>[];
        for (var data in response.data) {
          try {
            TorrentContentModel torrentContent =
                TorrentContentModel.fromJson(data);
            torrentContentList.add(torrentContent);
          } catch (error) {
            print(error.toString());
          }
        }
        BlocProvider.of<TorrentContentScreenBloc>(context, listen: false).add(
            SetTorrentContentListEvent(
                newTorrentContentList: torrentContentList));
        yield convertToFolder(torrentContentList);
      } catch (error) {
        print('--ERROR IN GET TORRENT CONTENT--' + error.toString());
        yield {};
      }
      await Future.delayed(Duration(seconds: 2), () {});
    }
  }

  static Future<void> setTorrentContentPriority({
    required BuildContext context,
    required String hash,
    required int priorityType,
    required List<int> indexList,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.setTorrentContentPriorityUrl +
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
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
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
      }
    } catch (error) {
      print('--ERROR IN SET TORRENT PRIORITY--');
      print(error.toString());
    }
  }

  static Future<bool> checkTorrentHash({
    required List<String> hashes,
    required BuildContext context,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.checkHash;
      print('---CHECK TORRENT HASH---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = hashes;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      //if hashcheck is successful then return true else return false
      if (response.statusCode == 200) {
        print('--HASH CHECKED--');
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('--ERROR IN HASH CHECK--');
      print(error.toString());
      //if error arises then return false
      return false;
    }
  }

  static Future<void> setTags(
      {required List<String> tagLits,
      required String hashes,
      required BuildContext context}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.setTags;
      print('---SET TAGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['hashes'] = [hashes];
      mp['tags'] = tagLits;
      String rawBody = json.encode(mp);
      response = await dio.patch(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--TAG ADDED--');
      }
    } catch (error) {
      print('--ERROR IN TAG ADD--');
      print(error);
    }
  }
}
