import 'package:flutter/cupertino.dart';

class UserDetailProvider extends ChangeNotifier {
  String token = '';
  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }
}
