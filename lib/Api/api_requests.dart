import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/torrent_model.dart';

class ApiRequests {
  // Gets list of torrents
  static Stream<List<TorrentModel>> getAllTorrents() async* {
    while (true) {
      try {
        Response response;
        Dio dio = new Dio();
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJpYXQiOjE2MTYzMDcyOTIsImV4cCI6MTYxNjkxMjA5Mn0._u2O1M0F4KeRQQNlPVcv7XUIJDDOMb7oPpdp3WJyMGU';
        // Map<String, dynamic> mp = Map();
        // mp['username'] = "test";
        // mp['password'] = "test";
        //
        // String rawBody = json.encode(mp);
        // response = await dio.post(
        //   'http://192.168.43.251:3000/api/auth/authenticate',
        //   data: rawBody,
        // );
        //
        // var cookie = response.headers;
        // dio.options.headers['Cookie'] =
        //     cookie['Set-Cookie'][0].toString().split(';')[0];
        // print(response.data);
        // print('Pratik');
        // print(cookie['Set-Cookie'][0].toString().split(';')[0]);
        response = await dio.get(
          'http://192.168.43.251:3000/api/torrents',
        );
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

  Future<void> getTorrentList() async {
    print('Pratik');
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJpYXQiOjE2MTYzMDcyOTIsImV4cCI6MTYxNjkxMjA5Mn0._u2O1M0F4KeRQQNlPVcv7XUIJDDOMb7oPpdp3WJyMGU';
      response = await dio.get(
        'http://192.168.43.251:3000/api/torrents',
      );
      print(response.data['torrents'].keys);
      for (var hash in response.data['torrents'].keys) {
        try {
          TorrentModel torrentModel =
              TorrentModel.fromJson(response.data['torrents'][hash]);
          print(torrentModel.name);
        } catch (e) {
          print(e.toString());
        }
      }
      print('Pratik');
    } catch (e) {
      print(e.toString());
    }
  }
}
