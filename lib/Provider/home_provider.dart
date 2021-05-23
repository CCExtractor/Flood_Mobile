import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<TorrentModel> torrentList = [];
  Map<String, dynamic> torrentListJson = {};

  String upSpeed = '0 KB/s';
  String downSpeed = '0 KB/s';
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

  void setTorrentListJson(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }

  void updateTorrentList(Map<String, dynamic> newTorrentListJson) {
    torrentListJson = newTorrentListJson;
    notifyListeners();
  }
}
