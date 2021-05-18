import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider extends ChangeNotifier {
  String baseUrl = 'http://localhost:3000';
  static String authenticateUrl = '/api/auth/authenticate';
  static String startTorrent = '/api/torrents/start';
  static String getTorrentList = '/api/torrents';
  static String stopTorrent = '/api/torrents/stop';
  static String eventsStream =
      '/api/activity-stream?historySnapshot=FIVE_MINUTE';

  Future<void> setBaseUrl(String url) async {
    baseUrl = url;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('baseUrl', url);
    notifyListeners();
  }
}
