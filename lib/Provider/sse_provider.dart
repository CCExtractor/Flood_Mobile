import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Constants/event_names.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class SSEProvider extends ChangeNotifier {
  SSEModel sseModel = SSEModel(data: '', id: '', event: '');

  void setSSEModel(model) {
    sseModel = model;
    notifyListeners();
  }

  void listenToSSE(BuildContext context) {
    SSEClient.subscribeToSSE(
            Provider.of<ApiProvider>(context).baseUrl +
                ApiProvider.eventsStreamUrl,
            Provider.of<UserDetailProvider>(context).token)
        .listen((event) {
      if (event.id != '' && event.data != '' && event.event != '') {
        // print('Id: ' + event.id!);
        // print('Event: ' + event.event!);
        // print('Data: ' + event.data!);
        sseModel = event;
        switch (event.event) {
          case Events.TRANSFER_SUMMARY_FULL_UPDATE:
            EventHandlerApi.setTransferRate(model: event, context: context);
            break;
          case Events.TORRENT_LIST_FULL_UPDATE:
            EventHandlerApi.setFullTorrentList(model: event, context: context);
            for (int i = 0;
                i <
                    Provider.of<HomeProvider>(context, listen: false)
                        .torrentList
                        .length;
                i++) {
              EventHandlerApi.showNotification(i, context);
            }
            break;
          case Events.TORRENT_LIST_DIFF_CHANGE:
            EventHandlerApi.updateFullTorrentList(
                model: event, context: context);
            for (int i = 0;
                i <
                    Provider.of<HomeProvider>(context, listen: false)
                        .torrentList
                        .length;
                i++) {
              EventHandlerApi.showNotification(i, context);
            }
            break;
          case Events.NOTIFICATION_COUNT_CHANGE:
            EventHandlerApi.setNotificationCount(
                model: event, context: context);
            for (int j = 0;
                j <
                    Provider.of<HomeProvider>(context, listen: false)
                        .torrentList
                        .length;
                j++) {
              if (Provider.of<HomeProvider>(context, listen: false)
                  .torrentList[j]
                  .status
                  .contains('complete')) {
                EventHandlerApi.showEventNotification(j, context);
              }
            }
            break;
        }
        notifyListeners();
      }
    });
  }

  void unsubscribeFromSSE() {
    SSEClient.unsubscribeFromSSE();
  }
}
