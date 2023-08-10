

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Constants/notification_keys.dart';
import 'package:flood_mobile/l10n/l10n.dart';

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
        actionKey != NotificationConstants.RESUME_ACTION_KEY &&
        actionKey != NotificationConstants.CANCEL_ACTION_KEY &&
        actionKey != NotificationConstants.STOP_ACTION_KEY) {
      return;
    }

    // Pause downloads
    if (actionKey == NotificationConstants.PAUSE_ACTION_KEY) {
      await TorrentApi.stopTorrent(
          hashes: [homeModel.state.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
    }

    // Resume downloads
    else if (actionKey == NotificationConstants.RESUME_ACTION_KEY) {
      await TorrentApi.startTorrent(
          hashes: [homeModel.state.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
    } else if (actionKey == NotificationConstants.CANCEL_ACTION_KEY) {
      BlocProvider.of<HomeScreenBloc>(
              NavigationService.navigatorKey.currentContext!,
              listen: false)
          .add(
        UpdateNotificationCancelEvent(
          newNotificationCancel: {
            homeModel.state.torrentList[receivedAction.id!].hash: true
          },
        ),
      );
    } else if (actionKey == NotificationConstants.STOP_ACTION_KEY) {
      await TorrentApi.stopTorrent(
          hashes: [homeModel.state.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
      BlocProvider.of<HomeScreenBloc>(
              NavigationService.navigatorKey.currentContext!,
              listen: false)
          .add(
        UpdateNotificationCancelEvent(
          newNotificationCancel: {
            homeModel.state.torrentList[receivedAction.id!].hash: true
          },
        ),
      );
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

Future<void> createTorrentDownloadNotification(
    int id, BuildContext context) async {
  late bool displayNotification;
  late bool isPaused;
  isPaused = true;
  HomeScreenState homeModel =
      BlocProvider.of<HomeScreenBloc>(context, listen: false).state;

  // Skip finished torrents
  if (homeModel.torrentList[id].status.contains('complete')) {
    displayNotification = false;
  } else {
    displayNotification = true;
  }

  // Torrent not being downloaded
  if (homeModel.torrentList[id].status.contains('downloading')) {
    // Change to the 'RESUME' action
    isPaused = false;
  } else if (homeModel.torrentList[id].status.contains('error')) {
    displayNotification = false;
  }

  // Torrent Paused
  else {
    isPaused = true;
  }

  // Create notification for unfinished downloads
  if (displayNotification) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        actionType: ActionType.Default,
        channelKey: NotificationConstants.DOWNLOADS_CHANNEL_KEY,
        category: NotificationCategory.Progress,
        notificationLayout: NotificationLayout.ProgressBar,
        title: homeModel.torrentList[id].name,
        body: isPaused
            ? "${context.l10n.notification_stopped} ETA: ∞"
            : "${context.l10n.notification_downloading} ETA: " +
                prettyDuration(
                  Duration(
                    seconds: homeModel.torrentList[id].eta.toInt(),
                  ),
                  abbreviated: true,
                ),
        progress: homeModel.torrentList[id].percentComplete.round(),
        summary: isPaused ? 'Paused' : 'Downloading',
        locked: true,
        autoDismissible: false,
        showWhen: false,
      ),
      actionButtons: [
        NotificationActionButton(
          key: isPaused
              ? NotificationConstants.RESUME_ACTION_KEY
              : NotificationConstants.PAUSE_ACTION_KEY,
          label: isPaused ? context.l10n.notification_resume : context.l10n.notification_pause,
          actionType: ActionType.KeepOnTop,
          enabled: true,
          autoDismissible: false,
        ),
        NotificationActionButton(
          key: isPaused
              ? NotificationConstants.CANCEL_ACTION_KEY
              : NotificationConstants.STOP_ACTION_KEY,
          label: isPaused ? context.l10n.notification_cancel : context.l10n.notification_stop,
          actionType: ActionType.KeepOnTop,
          enabled: true,
          autoDismissible: true,
        ),
      ],
    );
  }
}

Future<void> createDownloadFinishedNotification(
    int id, BuildContext context) async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: id,
    autoDismissible: false,
    channelKey: NotificationConstants.PUSH_NOTIFICATION_CHANNEL_KEY,
    category: NotificationCategory.Event,
    notificationLayout: NotificationLayout.Default,
    title: BlocProvider.of<HomeScreenBloc>(context, listen: false)
        .state
        .torrentList[id]
        .name,
    body: context.l10n.notification_finished,
  ));
}

Future<void> createDownloadErrorNotification(
    int id, BuildContext context) async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: id,
    autoDismissible: false,
    channelKey: NotificationConstants.PUSH_NOTIFICATION_CHANNEL_KEY,
    category: NotificationCategory.Event,
    notificationLayout: NotificationLayout.Default,
    title: BlocProvider.of<HomeScreenBloc>(context, listen: false)
        .state
        .torrentList[id]
        .name,
    body: context.l10n.notification_error,
    backgroundColor: Colors.red,
  ));
}
