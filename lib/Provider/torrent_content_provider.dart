import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flutter/cupertino.dart';

class TorrentContentProvider extends ChangeNotifier {
  bool isSelectionMode = false;
  List<TorrentContentModel> torrentContentList = [];
  List<int> selectedIndexList = [];

  void setSelectionMode() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  void setTorrentContentList(List<TorrentContentModel> newTorrentContentList) {
    torrentContentList = newTorrentContentList;
    notifyListeners();
  }

  void addItemToSelectedIndex(int index) {
    selectedIndexList.add(index);
    print(selectedIndexList);
    notifyListeners();
  }

  void removeItemFromSelectedList(int index) {
    selectedIndexList.remove(index);
    print(selectedIndexList);
    notifyListeners();
  }

  void removeAllItemsFromList() {
    selectedIndexList = [];
    notifyListeners();
  }
}
