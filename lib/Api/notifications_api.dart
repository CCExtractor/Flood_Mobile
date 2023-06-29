import 'package:dio/dio.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationApi {
  static Future<void> getNotifications({required BuildContext context}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.notifications;
      print('---GET NOTIFICATIONS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.get(url, queryParameters: {
        'id': 'notification-tooltip',
        'limit': 5,
        'start': 0
      });
      if (response.statusCode == 200) {
        print('---NOTIFICATIONS---');
        NotificationModel model = NotificationModel.fromJson(response.data);
        BlocProvider.of<HomeScreenBloc>(context, listen: false)
            .add(SetNotificationModelEvent(newModel: model));
      }
    } catch (error) {
      print('--ERROR IN GET NOTIFICATION--');
      print(error.toString());
    }
  }

  static Future<void> clearNotification({required BuildContext context}) async {
    try {
      String url =
          BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl +
              ApiEndpoints.notifications;
      print('---CLEAR NOTIFICATIONS---');
      print(url);
      Response response;
      Dio dio = new Dio();
      //Headers
      dio.options.headers['Accept'] = "application/json";
      dio.options.headers['Content-Type'] = "application/json";
      dio.options.headers['Connection'] = "keep-alive";
      dio.options.headers['Cookie'] =
          BlocProvider.of<UserDetailBloc>(context, listen: false).token;
      response = await dio.delete(url);
      if (response.statusCode == 200) {
        print('---NOTIFICATIONS CLEARED---');
        print(response);
        await getNotifications(context: context);
      } else {
        print('---ERROR---');
      }
    } catch (error) {
      print('--ERROR IN CLEAR NOTIFICATION--');
      print(error.toString());
    }
  }
}
