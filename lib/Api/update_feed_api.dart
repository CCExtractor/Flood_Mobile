import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateFeedApi {
  static Future<void> updateFeed({
    required String type,
    required String id,
    required String label,
    required String feedurl,
    required BuildContext context,
    required int interval,
    required int count,
  }) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.addFeeds +
              "/" +
              id;
      print('---UPDATE RSS FEED---');
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
      mp['type'] = type;
      mp['_id'] = id;
      mp['label'] = label;
      mp['url'] = feedurl;
      mp['interval'] = interval;
      mp['count'] = count;
      String rawBody = json.encode(mp);
      response = await dio.patch(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--FEED UPDATED--');
      }
    } catch (error) {
      print('--ERROR IN UPDATING FEED--');
      print(error.toString());
    }
  }
}
