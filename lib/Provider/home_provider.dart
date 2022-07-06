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
  Map<String, dynamic> RssFeedsListJson = {};
  List<FeedsAndRulesModel> RssFeedsList = [];
  List<RulesModel> RssRulesList = [];
  List<FeedsContentsModel> RssFeedsContentsList = [];

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

  void setRssFeedsList(List<FeedsAndRulesModel> newRssFeedsList, List<RulesModel> newRssRulesList) {
    RssRulesList = newRssRulesList;
    RssFeedsList = newRssFeedsList;
    notifyListeners();
  }

  void setRssFeedsContentsList(List<FeedsContentsModel> newRssFeedsContentsList) {
    RssFeedsContentsList = newRssFeedsContentsList;
    notifyListeners();
  }

  void setTorrentListJson(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }

  void setFeedsAndRulesListJson(Map<String, dynamic> newRssFeedsListJson) {
    RssFeedsListJson = newRssFeedsListJson;
    notifyListeners();
  }

  void updateTorrentList(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }
}
