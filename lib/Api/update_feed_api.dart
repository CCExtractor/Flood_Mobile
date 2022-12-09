import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/user_detail_provider.dart';

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
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addFeeds +
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
          Provider.of<UserDetailProvider>(context, listen: false).token;
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
      } else {}
    } catch (e) {
      print('--ERROR IN UPDATING FEED--');
      print(e.toString());
    }
  }
}
