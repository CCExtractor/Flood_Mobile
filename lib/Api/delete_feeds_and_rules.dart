import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/api_provider.dart';
import '../Provider/user_detail_provider.dart';

class DeleteFeedOrRulesApi {
  static Future<void> deleteFeedsOrRules(
      {required BuildContext context, required String id}) async {
    try {
      Response response;
      Dio dio = new Dio();
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.listAllFeedsAndRules +
          "/" +
          id;
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      Map<String, dynamic> mp = Map();
      mp['id'] = id;
      String rawBody = json.encode(mp);
      response = await dio.delete(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print("Feeds or Rules Deleted");
      } else {
        print("There is some problem status code not 200");
      }
    } catch (e) {
      print('Exception caught in Api Request ' + e.toString());
    }
  }
}
