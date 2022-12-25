import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flutter/cupertino.dart';

class UserDetailProvider extends ChangeNotifier {
  String token = '';
  String username = '';
  late List<CurrentUserDetailModel> usersList = [];

  void setUserDetails(String newToken, String newUsername) {
    token = newToken;
    username = newUsername;
    notifyListeners();
  }

  void setUsersList(newUsersList) {
    usersList = newUsersList;
    notifyListeners();
  }
}
