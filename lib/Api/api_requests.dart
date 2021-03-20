import 'dart:convert';
import 'package:dio/dio.dart';

class ApiRequests {
  /// This class will be responsible for making all API Calls to the ruTorrent server

  /// Gets list of torrents for a particular account
  // static Stream<List<Torrent>> getTorrentList(
  //     Api api, GeneralFeatures general) async* {
  //   while (true) {
  //     try {
  //       var response = await api.ioClient.post(Uri.parse(api.httpRpcPluginUrl),
  //           headers: api.getAuthHeader(),
  //           body: {
  //             'mode': 'list',
  //           });
  //
  //       yield parseTorrentsData(response.body, general, api);
  //     } catch (e) {
  //       print('Exception caught in Api Request ' + e.toString());
  //       /*returning null since the stream has to be active all the times to return something
  //         this usually occurs when there is no torrent task available or when the connect
  //         to rTorrent is not established
  //       */
  //       yield null;
  //     }
  //     // Producing artificial delay of one second
  //     await Future.delayed(Duration(seconds: 1), () {});
  //   }
  // }
  Future<void> getTorrentList() async {
    print('Pratik');
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      // dio.options.headers['Cookie'] =
      //     "_session_id=9aa4c1a31c9697a21f916713e6abd2c0ab5abe71d9b4428b60503ff3db3fa4ce4650; ext_name=ojplmecpdpgccookcobabopnaifgidhf";

      Map<String, dynamic> mp = Map();
      mp['username'] = "test";
      mp['password'] = "test";

      String rawBody = json.encode(mp);
      response = await dio.post(
        'http://192.168.43.251:3000/api/auth/authenticate',
        data: rawBody,
      );

      var cookie = response.headers;
      dio.options.headers['Cookie'] =
          cookie['Set-Cookie'][0].toString().split(';')[0];
      print(response.data);
      print('Pratik');
      print(cookie['Set-Cookie'][0].toString().split(';')[0]);
      // rawBody = json.encode(<String, dynamic>{
      //   "method": "web.update_ui",
      //   "params": [
      //     [
      //       "queue",
      //       "name",
      //       "total_wanted",
      //       "state",
      //       "progress",
      //       "num_seeds",
      //       "total_seeds",
      //       "num_peers",
      //       "total_peers",
      //       "download_payload_rate",
      //       "upload_payload_rate",
      //       "eta",
      //       "ratio",
      //       "distributed_copies",
      //       "is_auto_managed",
      //       "time_added",
      //       "tracker_host",
      //       "download_location",
      //       "last_seen_complete",
      //       "total_done",
      //       "total_uploaded",
      //       "max_download_speed",
      //       "max_upload_speed",
      //       "seeds_peers_ratio",
      //       "total_remaining",
      //       "completed_time",
      //       "time_since_transfer"
      //     ],
      //     {"owner": "test"}
      //   ],
      //   "id": 25
      // });
      response = await dio.get(
        'http://192.168.43.251:3000/api/torrents',
      );
      print(response.data['torrents']);
      print('Pratik');
    } catch (e) {
      print(e.toString());
    }
  }
}
