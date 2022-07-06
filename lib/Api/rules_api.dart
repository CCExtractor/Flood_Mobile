import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Provider/api_provider.dart';
import '../Provider/user_detail_provider.dart';

class RulesApi {
  static Future<void> addRules({
    required String type,
    required String label,
    required List<String> feedIDs,
    required String field,
    required BuildContext context,
    required String matchpattern,
    required String excludepattern,
    required String destination,
    required List<String> tags,
    required bool startOnLoad,
    required bool isBasePath,
    required int count,
  }) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addRules;
      print('---ADD RSS RULES---');
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
      mp['label'] = label;
      mp['feedIDs'] = feedIDs;
      mp['field'] = field;
      mp['match'] = matchpattern;
      mp['exclude'] = excludepattern;
      mp['destination'] = destination;
      mp['tags'] = tags;
      mp['startOnLoad'] = startOnLoad;
      mp['isBasePath'] = isBasePath;
      mp['count'] = count;
      String rawBody = json.encode(mp);
      response = await dio.put(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--RULES ADDED--');
      } else {}
    } catch (e) {
      print('--ERROR IN ADDING RULES--');
      print(e.toString());
    }
  }
}
