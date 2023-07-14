import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';

class DeleteFeedOrRulesApi {
  static Future<void> deleteFeedsOrRules(
      {required BuildContext context, required String id}) async {
    try {
      Response response;
      Dio dio = new Dio();
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.listAllFeedsAndRules +
              "/" +
              id;
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
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
    } catch (error) {
      print('--ERROR IN DELETE FEEDS AND RULES--' + error.toString());
    }
  }
}
