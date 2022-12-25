import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/api_provider.dart';

class AuthApi {
  static Future<bool> loginUser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.authenticateUrl;
      print('---LOGIN USER---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options
        ..headers['Accept'] = "application/json"
        ..headers['Content-Type'] = "application/json"
        ..headers['Connection'] = "keep-alive";
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
        // TODO(owner): check logic
        String? token =
            response.headers['Set-Cookie']?[0].toString().split(';')[0];
        print('Token $token');
        if (token != null) {
          // Setting token in shared preference
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('floodToken', token);
          await prefs.setString('floodUsername', username);
          Provider.of<UserDetailProvider>(context, listen: false)
              .setUserDetails(token, username);
          return true;
        }
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
      return false;
    }
  }

  static Future<void> registerUser({
    required RegisterUserModel model,
    required BuildContext context,
  }) async {
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

  static getUsersList(BuildContext context) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.getUsersList;
      print('---GET USERS LIST---');
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
        List<CurrentUserDetailModel> usersList = [];
        for (final user in response.data) {
          usersList.add(CurrentUserDetailModel.fromJson(user));
        }
        Provider.of<UserDetailProvider>(context, listen: false)
            .setUsersList(usersList);
        print('---USERS LIST---');
        print(response);
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }

  static deleteUser(BuildContext context, String username) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.deleteUser + "/" + username;
      print('---DELETE USER---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.delete(
        url,
      );
      if (response.statusCode == 200) {
        print(response);
        print('---USER DELETED---');
        // *Getting the users list again
        getUsersList(context);
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
