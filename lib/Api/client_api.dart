import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ClientApi {
  static Future<bool> checkClientOnline(BuildContext context) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl + ApiProvider.getClientSettingsUrl;
      print('---CHECK CLIENT ONLINE---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] = Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
      return false;
    }
  }

  static getClientSettings(BuildContext context) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl + ApiProvider.getClientSettingsUrl;
      print('---GET CLIENT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] = Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        ClientSettingsModel clientSetting = ClientSettingsModel.fromJson(response.data);
        Provider.of<ClientSettingsProvider>(context, listen: false).setClientSettings(clientSetting);
        print('---CLIENT SETTINGS---');
        print(response);
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> setClientSettings({required BuildContext context, required ClientSettingsModel model}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl + ApiProvider.setClientSettingsUrl;
      print('---SET TORRENT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] = Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = model.toJson();
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio.patch(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print(response);
        print('--SETTINGS CHANGED--');
        // *Getting the client settings again
        getClientSettings(context);
      } else {
        print('Error');
      }
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static Future<void> setSpeedLimit(
      {required BuildContext context, required String downSpeed, required String upSpeed}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl + ApiProvider.setClientSettingsUrl;
      print('---SET SPEED LIMIT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] = Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['throttleGlobalDownSpeed'] = TransferSpeedManager.speedToValMap[downSpeed];
      mp['throttleGlobalUpSpeed'] = TransferSpeedManager.speedToValMap[upSpeed];
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio.patch(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print(response);
        print('--SPEED LIMIT CHANGED--');
        // *Getting the client settings again
        getClientSettings(context);
      } else {
        print('Error');
      }
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
