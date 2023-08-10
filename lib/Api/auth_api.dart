import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flood_mobile/Model/register_user_model.dart';

class AuthApi {
  static Future<bool> loginUser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      String url = BlocProvider.of<ApiBloc>(context).state.baseUrl +
          ApiEndpoints.authenticateUrl;
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
        String? token =
            response.headers['Set-Cookie']?[0].toString().split(';')[0];
        print('Token $token');
        if (token != null) {
          // Setting token in shared preference
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('floodToken', token);
          await prefs.setString('floodUsername', username);
          BlocProvider.of<UserDetailBloc>(context, listen: false)
              .add(SetUserDetailsEvent(token: token, username: username));
          return true;
        }
        return false;
      } else {
        return false;
      }
    } catch (error) {
      print('--ERROR IN LOGIN USER--');
      print(error.toString());
      return false;
    }
  }

  static Future<void> registerUser({
    required RegisterUserModel model,
    required BuildContext context,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.registerUser;
      print('---REGISTER USER---');
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
      response = await dio
          .post(url, data: rawBody, queryParameters: {"cookie": false});
      if (response.statusCode == 200) {
        print(response);
        getUsersList(context);
      }
    } catch (error) {
      print('--ERROR IN REGISTER USER--');
      print(error.toString());
    }
  }

  static getUsersList(BuildContext context) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.getUsersList;
      print('---GET USERS LIST---');
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
        List<CurrentUserDetailModel> usersList = [];
        for (final user in response.data) {
          usersList.add(CurrentUserDetailModel.fromJson(user));
        }
        BlocProvider.of<UserDetailBloc>(context, listen: false)
            .add(SetUsersListEvent(usersList: usersList));
        print('---USERS LIST---');
      }
    } catch (error) {
      print('--ERROR IN GET USER LIST--');
      print(error.toString());
    }
  }

  static deleteUser(BuildContext context, String username) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.deleteUser +
              "/" +
              username;
      print('---DELETE USER---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.delete(
        url,
      );
      if (response.statusCode == 200) {
        print(response);
        print('---USER DELETED---');
        // *Getting the users list again
        getUsersList(context);
      }
    } catch (error) {
      print('--ERROR IN DELETE USER--');
      print(error.toString());
    }
  }
}
