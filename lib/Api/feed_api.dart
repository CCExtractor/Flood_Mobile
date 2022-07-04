import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/rss_feeds_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/single_feed_and_response_model.dart';
import '../Model/single_rule_model.dart';
import '../Provider/api_provider.dart';
import '../Provider/user_detail_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';

List<FeedsAndRulesModel> feedsandrules = [];
List<RulesModel> rssrules = [];
class FeedsApi{
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
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addFeeds;
      print('---ADD RSS FEED---');
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
      response = await dio.put(
        url,
        data: rawBody,
      );
      if (response.statusCode == 200) {
        print('--FEED ADDED--');
      } else {}
    } catch (e) {
      print('--ERROR IN ADDING FEEDS--');
      print(e.toString());
    }
  }


  static Future<void> listAllFeedsAndRules(
      {required BuildContext context}) async{
    RssFeedsModel rssfeedsmodel;
      try {
        Response response;
        Dio dio = new Dio();
        String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
            ApiProvider.listAllFeedsAndRules;
        dio.options.headers['Accept'] = "application/json";
        dio.options.headers['Content-Type'] = "application/json";
        dio.options.headers['Connection'] = "keep-alive";
        dio.options.headers['Cookie'] =
            Provider.of<UserDetailProvider>(context, listen: false).token;
        response = await dio.get(url);
        if (response.statusCode == 200) {
            rssfeedsmodel = RssFeedsModel.fromJson(response.data);
            feedsandrules = rssfeedsmodel.feeds;
            rssrules = rssfeedsmodel.rules;
            Provider.of<HomeProvider>(context, listen: false)
                .setRssFeedsList(feedsandrules);
            Provider.of<HomeProvider>(context, listen: false)
                .setRssRulesList(rssrules);
            print("Feeds and Rules Listed");
        } else {
          print("There is some problem status code not 200");
        }
      } catch (e) {
        print('Exception caught in Api Request ' + e.toString());
      }
    }
  }

