import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationApi {
  static Future<void> getNotifications({@required BuildContext context}) async {
    try {
      String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
          ApiProvider.notifications;
      print('---GET NOTIFICATIONS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          Provider.of<UserDetailProvider>(context, listen: false).token;
      response = await dio.get(url, queryParameters: {
        'id': 'notification-tooltip',
        'limit': 5,
        'start': 0
      });
      if (response.statusCode == 200) {
        print('---NOTIFICATIONS---');
        NotificationModel model = NotificationModel.fromJson(response.data);
        Provider.of<HomeProvider>(context, listen: false)
            .setNotificationModel(model);
        Provider.of<HomeProvider>(context, listen: false)
            .setUnreadNotifications(model.unread);
      } else {}
    } catch (e) {
      print('--ERROR--');
      print(e.toString());
    }
  }
}
