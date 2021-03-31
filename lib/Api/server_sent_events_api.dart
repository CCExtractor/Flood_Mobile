import 'dart:convert';

import 'package:flood_mobile/Api/api.dart';
import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Services/byte_to_gbmb_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SSEApi {
  static http.Client _client;
  static void subscribeToSSE(BuildContext context) {
    print("--SUBSCRIBING TO SSE---");
    try {
      _client = http.Client();
      String url = Api.baseUrl + Api.eventsStream;
      var request = new http.Request("GET", Uri.parse(url));
      request.headers["Cache-Control"] = "no-cache";
      request.headers["Accept"] = "text/event-stream";
      request.headers["Cookie"] =
          Provider.of<UserDetailProvider>(context, listen: false).token;

      Future<http.StreamedResponse> response = _client.send(request);

      response.asStream().listen((streamedResponse) {
        streamedResponse.stream.listen((data) {
          final parsedData = utf8.decode(data);
          final eventType = parsedData.split("\n")[1];
          if (eventType != null && eventType != '') {
            //Checking for transfer rate
            if (eventType.split(':')[1] == 'TRANSFER_SUMMARY_DIFF_CHANGE') {
              String data = parsedData.split("\n")[2].split('data:')[1];
              if (data != '[]') {
                String upSpeed = '0';
                String downSpeed = '0';
                List<dynamic> dat = json.decode(data);
                List<RateModel> rateList = [];
                for (var i in dat) {
                  rateList.add(RateModel.fromJson(i));
                }
                for (RateModel model in rateList) {
                  if (model.path == '/downRate') {
                    downSpeed =
                        byteToGbMbKbConverter(byte: model.value.toDouble());
                  } else if (model.path == '/upRate') {
                    upSpeed =
                        byteToGbMbKbConverter(byte: model.value.toDouble());
                  }
                }
                Provider.of<HomeProvider>(context, listen: false)
                    .setSpeed(upSpeed, downSpeed);
              }
            }
          }
        });
      });
    } catch (e) {
      print("Caught $e");
    }
  }

  static void unsubscribeFromSSE() {
    _client.close();
  }
}
