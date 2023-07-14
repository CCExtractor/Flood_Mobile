import 'package:dio/dio.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsContentsApi {
  static Future<void> listAllFeedsContents(
      {required BuildContext context, required String id}) async {
    try {
      Response response;
      Dio dio = new Dio();
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.addFeeds +
              "/" +
              id +
              "/items";
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.get(url);
      if (response.statusCode == 200) {
        List<FeedsContentsModel> feedContentList = <FeedsContentsModel>[];
        for (var data in response.data) {
          try {
            FeedsContentsModel feedContent = FeedsContentsModel.fromJson(data);
            feedContentList.add(feedContent);
          } catch (error) {
            print(error.toString());
          }
        }
        BlocProvider.of<HomeScreenBloc>(context, listen: false).add(
            SetRssFeedsContentsListEvent(
                newRssFeedsContentsList: feedContentList));
        print("Feeds Contents Listed");
      } else {
        print("There is some problem status code not 200");
      }
    } catch (error) {
      print('--ERROR IN LIST FEEDS CONTENT--' + error.toString());
    }
  }
}
