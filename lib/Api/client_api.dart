import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientApi {
  static getClientSettings(BuildContext context) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.getClientSettingsUrl;
      print('---GET CLIENT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        ClientSettingsModel clientSetting =
            ClientSettingsModel.fromJson(response.data);
        BlocProvider.of<ClientSettingsBloc>(context, listen: false)
            .add(SetClientSettingsEvent(clientSettings: clientSetting));
        print('---CLIENT SETTINGS---');
        print(response);
      }
    } catch (error) {
      print('--ERROR IN GET CLIENT SETTINGS--');
      print(error.toString());
    }
  }

  static Future<void> setClientSettings(
      {required BuildContext context,
      required ClientSettingsModel model}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.setClientSettingsUrl;
      print('---SET TORRENT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
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
    } catch (error) {
      print('--ERROR IN SET CLIENT SETTINGS--');
      print(error.toString());
    }
  }

  static Future<void> setSpeedLimit(
      {required BuildContext context,
      required String downSpeed,
      required String upSpeed}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.setClientSettingsUrl;
      print('---SET SPEED LIMIT SETTINGS---');
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
      mp['throttleGlobalDownSpeed'] =
          TransferSpeedManager.speedToValMap[downSpeed];
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
    } catch (error) {
      print('--ERROR IN SPEED LIMIT CHANGED--');
      print(error.toString());
    }
  }

  static Future<bool> checkClientOnline(BuildContext context) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.getClientSettingsUrl;
      print('---CHECK CLIENT ONLINE---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('--ERROR IN CHECK CLIENT ONLINE--');
      print(error.toString());
      return false;
    }
  }
}
