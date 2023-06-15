import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Constants/api_endpoints.dart';
import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Constants/event_names.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';

part 'sse_state.dart';
part 'sse_event.dart';

class SSEBloc extends Bloc<SSEEvent, SSEState> {
  SSEModel sseModel = SSEModel(data: '', id: '', event: '');

  SSEBloc() : super(SSEInitial()) {
    on<SSEEvent>((event, emit) {});

    on<SetSSEEvent>(((event, emit) {
      // Update the sseModel variable with the new SSE model
      emit(SetSSEState(sseModel: event.sseModel));
      sseModel = event.sseModel;
    }));

    on<SetSSEListenEvent>((event, emit) {
      emit(SSEListenState(context: event.context));
      SSEClient.subscribeToSSE(
          url: BlocProvider.of<ApiBloc>(event.context).state.baseUrl +
              ApiEndpoints.eventsStreamUrl,
          method: SSERequestType.GET,
          header: {
            "Cookie": BlocProvider.of<UserDetailBloc>(event.context).token,
            "Accept": "text/event-stream",
            "Cache-Control": "no-cache",
          }).listen((listenEvent) {
        if (listenEvent.id != '' &&
            listenEvent.data != '' &&
            listenEvent.event != '') {
          sseModel = listenEvent;
          switch (listenEvent.event) {
            case Events.TRANSFER_SUMMARY_FULL_UPDATE:
              EventHandlerApi.setTransferRate(
                  model: listenEvent, context: event.context);
              break;
            case Events.TORRENT_LIST_FULL_UPDATE:
              EventHandlerApi.setFullTorrentList(
                  model: listenEvent, context: event.context);
              for (int i = 0;
                  i <
                      BlocProvider.of<HomeScreenBloc>(event.context,
                              listen: false)
                          .state
                          .torrentList
                          .length;
                  i++) {
                EventHandlerApi.showNotification(i, event.context);
              }
              break;
            case Events.TORRENT_LIST_DIFF_CHANGE:
              EventHandlerApi.updateFullTorrentList(
                  model: listenEvent, context: event.context);
              for (int i = 0;
                  i <
                      BlocProvider.of<HomeScreenBloc>(event.context,
                              listen: false)
                          .state
                          .torrentList
                          .length;
                  i++) {
                EventHandlerApi.showNotification(i, event.context);
              }
              break;
            case Events.NOTIFICATION_COUNT_CHANGE:
              EventHandlerApi.setNotificationCount(
                  model: listenEvent, context: event.context);
              for (int j = 0;
                  j <
                      BlocProvider.of<HomeScreenBloc>(event.context,
                              listen: false)
                          .state
                          .torrentList
                          .length;
                  j++) {
                if (BlocProvider.of<HomeScreenBloc>(event.context,
                        listen: false)
                    .state
                    .torrentList[j]
                    .status
                    .contains('complete')) {
                  EventHandlerApi.showEventNotification(j, event.context);
                }
              }
              break;
          }
        }
      });
    });

    on<SetSSEUnsubscribeEvent>(((event, emit) {
      // Emit SSEUnsubscribeState to indicate unsubscribing from SSE
      emit(SSEUnsubscribeState());
      SSEClient.unsubscribeFromSSE();
    }));
  }
}
