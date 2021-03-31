import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  String upSpeed = '0 KB/s';
  String downSpeed = '0 KB/s';
  void setSpeed(String up, String down) {
    upSpeed = up + '/s';
    downSpeed = down + '/s';
    notifyListeners();
  }
}
