import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Constants/notification_keys.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationController {
  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    HomeScreenBloc homeModel = BlocProvider.of<HomeScreenBloc>(
        NavigationService.navigatorKey.currentContext!,
        listen: false);
    final actionKey = receivedAction.buttonKeyPressed;

    // Not a desired action
    if (actionKey != NotificationConstants.PAUSE_ACTION_KEY &&
        actionKey != NotificationConstants.RESUME_ACTION_KEY) {
      return;
    }

    // Pause downloads
    if (actionKey == NotificationConstants.PAUSE_ACTION_KEY) {
      await TorrentApi.stopTorrent(
          hashes: [homeModel.state.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
    }

    // Resume downloads
    else {
      await TorrentApi.startTorrent(
          hashes: [homeModel.state.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
