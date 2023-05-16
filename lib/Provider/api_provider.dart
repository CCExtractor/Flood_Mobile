import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier {
  String baseUrl = 'http://localhost:3000';
  static String authenticateUrl = '/api/auth/authenticate';
  static String getUsersList = '/api/auth/users';
  static String registerUser = '/api/auth/register';
  static String deleteUser = '/api/auth/users';
  static String startTorrentUrl = '/api/torrents/start';
  static String getTorrentListUrl = '/api/torrents';
  static String stopTorrentUrl = '/api/torrents/stop';
  static String getClientSettingsUrl = '/api/client/settings';
  static String setClientSettingsUrl = '/api/client/settings';
  static String addTorrentMagnet = '/api/torrents/add-urls';
  static String addTorrentFile = '/api/torrents/add-files';
  static String deleteTorrent = '/api/torrents/delete';

  // api/torrents/{hash}/contents
  static String getTorrentContent = '/api/torrents/';

  // api/torrents/{hash}/contents/{id}/data?token={jwt token}
  static String playTorrentVideo = '/api/torrents/';
  static String eventsStreamUrl =
      '/api/activity-stream?historySnapshot=FIVE_MINUTE';

  // api/torrents/{hash}/contents
  static String setTorrentContentPriorityUrl = '/api/torrents/';

  //api/notifications?id=notification-tooltip&limit=10&start=0
  static String notifications = '/api/notifications';
  static String checkHash = '/api/torrents/check-hash';

  static String addFeeds = '/api/feed-monitor/feeds';
  static String addRules = '/api/feed-monitor/rules';

  // /api/feed-monitor/feeds/{id}
  static String listAllFeedsAndRules = '/api/feed-monitor';

  static String setTags = '/api/torrents/tags';

  Future<void> setBaseUrl(String url) async {
    baseUrl = url;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('baseUrl', url);
    notifyListeners();
  }
}
