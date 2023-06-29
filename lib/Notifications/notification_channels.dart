import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flood_mobile/Constants/notification_keys.dart';
import 'package:flutter/material.dart';

List<NotificationChannel> notificationChannelsList = [
  NotificationChannel(
    channelKey: NotificationConstants.DOWNLOADS_CHANNEL_KEY,
    channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY1,
    channelName: 'Downloads Channel',
    channelDescription: 'Notification channel for displaying torrent downloads',
    defaultColor: Color(0xff0E2537),
    ledColor: Colors.white,
    playSound: true,
    enableVibration: true,
    locked: true,
  ),
  NotificationChannel(
    channelKey: NotificationConstants.PUSH_NOTIFICATION_CHANNEL_KEY,
    channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY2,
    channelName: 'Push Notification Channel',
    channelDescription:
        'Notification channel for displaying push notifications',
    defaultColor: Color(0xff0E2537),
    ledColor: Colors.white,
    playSound: true,
    enableVibration: true,
  ),
];
List<NotificationChannelGroup> notificationChannelsGroupList = [
  NotificationChannelGroup(
      channelGroupName: 'Download Channel',
      channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY1),
  NotificationChannelGroup(
      channelGroupName: 'Push Notification Channel',
      channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY2),
];
