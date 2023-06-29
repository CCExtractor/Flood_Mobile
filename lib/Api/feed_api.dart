import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Model/rss_feeds_model.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';

class FeedsApi {
  static Future<void> addFeeds({
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
              ApiEndpoints.addFeeds;
      print('---ADD RSS FEED---');
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
      response = await dio.put(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--FEED ADDED--');
      }
    } catch (error) {
      print('--ERROR IN ADDING FEEDS--');
      print(error.toString());
    }
  }

  static Future<void> listAllFeedsAndRules(
      {required BuildContext context}) async {
    List<FeedsAndRulesModel> feedsandrules = [];
    List<RulesModel> rssrules = [];
    RssFeedsModel rssfeedsmodel;
    try {
      Response response;
      Dio dio = new Dio();
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.listAllFeedsAndRules;
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.get(url);
      if (response.statusCode == 200) {
        rssfeedsmodel = RssFeedsModel.fromJson(response.data);
        feedsandrules = rssfeedsmodel.feeds;
        rssrules = rssfeedsmodel.rules;
        BlocProvider.of<HomeScreenBloc>(context, listen: false).add(
            SetRssFeedsListEvent(
                newRssFeedsList: feedsandrules, newRssRulesList: rssrules));

        print("Feeds and Rules Listed");
      } else {
        print("There is some problem status code not 200");
      }
    } catch (error) {
      print('--ERROR IN LIST FEEDS AND RULES-- ' + error.toString());
    }
  }
}
