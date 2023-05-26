import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/material.dart';

class MultipleSelectTorrentProvider extends ChangeNotifier {
  bool isSelectionMode = false;
  List<TorrentModel> selectedTorrentList = [];
  List<int> selectedTorrentIndex = [];

  void changeSelectionMode() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }

  void addItemToList(TorrentModel model) {
    selectedTorrentList.add(model);
    notifyListeners();
  }

  void removeItemFromList(TorrentModel model) {
    selectedTorrentList.removeWhere((element) => element.hash == model.hash);
    notifyListeners();
  }

  void addAllItemsToList(List<TorrentModel> models) {
    selectedTorrentList.addAll(models);
    notifyListeners();
  }

  void removeAllItemsFromList() {
    selectedTorrentList = [];
    notifyListeners();
  }

  void addIndexToList(List<int> index) {
    index.forEach((element) {
      if (!selectedTorrentIndex.contains(element))
        selectedTorrentIndex.add(element);
    });
    notifyListeners();
  }

  void removeIndexFromList(List<int> index) {
    selectedTorrentIndex.removeWhere((element) => index.contains(element));
    notifyListeners();
  }

  void addAllIndexToList(List<int> index) {
    selectedTorrentIndex.addAll(index);
    notifyListeners();
  }

  void removeAllIndexFromList() {
    selectedTorrentIndex = [];
    notifyListeners();
  }
}
