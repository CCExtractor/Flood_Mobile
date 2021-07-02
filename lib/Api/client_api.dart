import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ClientApi {
  static getClientSettings(BuildContext context) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.getClientSettingsUrl;
      print('---GET CLIENT SETTINGS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        ClientSettingsModel clientSetting =
            ClientSettingsModel.fromJson(response.data);
        Provider.of<ClientSettingsProvider>(context, listen: false)
            .setClientSettings(clientSetting);
        print('---CLIENT SETTINGS---');
        print(response);
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
