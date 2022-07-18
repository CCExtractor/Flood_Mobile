import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/api_provider.dart';
import '../Provider/home_provider.dart';
import '../Provider/user_detail_provider.dart';

class FeedsContentsApi {
  static Future<void> listAllFeedsContents(
      {required BuildContext context, required String id}) async {
    try {
      Response response;
      Dio dio = new Dio();
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.addFeeds +
          "/" +
          id +
          "/items";
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.get(url);
      if (response.statusCode == 200) {
        List<FeedsContentsModel> feedContentList = <FeedsContentsModel>[];
        for (var data in response.data) {
          try {
            FeedsContentsModel feedContent = FeedsContentsModel.fromJson(data);
            feedContentList.add(feedContent);
          } catch (e) {
            print(e.toString());
          }
        }
        Provider.of<HomeProvider>(context, listen: false)
            .setRssFeedsContentsList(feedContentList);
        print("Feeds Contents Listed");
      } else {
        print("There is some problem status code not 200");
      }
    } catch (e) {
      print('Exception caught in Api Request ' + e.toString());
    }
  }
}
