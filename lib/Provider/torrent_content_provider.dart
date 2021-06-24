import 'package:flutter/cupertino.dart';

class TorrentContentProvider extends ChangeNotifier {
  bool isSelectionMode = false;

  void setSelectionMode() {
    isSelectionMode = !isSelectionMode;
    notifyListeners();
  }
}
