import 'package:flood_mobile/Model/feeds_content_model.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/cupertino.dart';
import '../Model/single_feed_and_response_model.dart';
import '../Model/single_rule_model.dart';

class HomeProvider extends ChangeNotifier {
  List<TorrentModel> torrentList = [];
  Map<String, dynamic> torrentListJson = {};
  int unreadNotifications = 0;
  late NotificationModel notificationModel;
  Map<String, dynamic> rssFeedsListJson = {};
  List<FeedsAndRulesModel> rssFeedsList = [];
  List<RulesModel> rssRulesList = [];
  List<FeedsContentsModel> rssFeedsContentsList = [];

  String upSpeed = '0 KB/s';
  String downSpeed = '0 KB/s';

  void setUnreadNotifications(int count) {
    unreadNotifications = count;
    notifyListeners();
  }

  void setNotificationModel(NotificationModel newModel) {
    notificationModel = newModel;
    notifyListeners();
  }

  void setSpeed(String up, String down) {
    upSpeed = up + '/s';
    downSpeed = down + '/s';
    notifyListeners();
  }

  void setTorrentList(List<TorrentModel> newTorrentList) {
    torrentList = newTorrentList;
    torrentList.sort((a, b) {
      return a.dateAdded.compareTo(b.dateAdded);
    });
    notifyListeners();
  }

  void setRssFeedsList(List<FeedsAndRulesModel> newRssFeedsList,
      List<RulesModel> newRssRulesList) {
    rssRulesList = newRssRulesList;
    rssFeedsList = newRssFeedsList;
    notifyListeners();
  }

  void setRssFeedsContentsList(
      List<FeedsContentsModel> newRssFeedsContentsList) {
    rssFeedsContentsList = newRssFeedsContentsList;
    notifyListeners();
  }

  void setTorrentListJson(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }

  void setFeedsAndRulesListJson(Map<String, dynamic> newRssFeedsListJson) {
    rssFeedsListJson = newRssFeedsListJson;
    notifyListeners();
  }

  void updateTorrentList(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }
}
