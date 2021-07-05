import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/api_provider.dart';

class AuthApi {
  static Future<bool> loginUser(
      {@required String username,
      @required String password,
      @required BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.authenticateUrl;
      print('---LOGIN USER---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      Map<String, dynamic> mp = Map();
      mp['username'] = username;
      mp['password'] = password;
      String rawBody = json.encode(mp);
      response = await dio.post(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        //Successfully Logged in
        print(response.data);
        String token =
            response.headers['Set-Cookie'][0].toString().split(';')[0];
        print('Token ' + token);
        // Setting token in shared preference
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('floodToken', token);
        Provider.of<UserDetailProvider>(context, listen: false).setToken(token);
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

  static Future<void> registerUser(
      {RegisterUserModel model, BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.registerUser;
      print('---REGISTER USER---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = model.toJson();
      String rawBody = json.encode(mp);
      print(rawBody);
      response = await dio
          .post(url, data: rawBody, queryParameters: {"cookie": false});
      print(response);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
