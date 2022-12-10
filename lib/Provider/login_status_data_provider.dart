import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusDataProvider extends ChangeNotifier {
  bool loggedInData = false;
  bool batteryOptimizationInfoSeen = false;

  Future<void> setLoggedInStatus(bool newLoggedInData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedInData', newLoggedInData);
    notifyListeners();
  }

  Future<void> setBatteryOptimizationInfoStatus(
      bool newBatteryOptimizationInfoSeen) async {
    batteryOptimizationInfoSeen = batteryOptimizationInfoSeen;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
        'batteryOptimizationInfoSeen', newBatteryOptimizationInfoSeen);
    notifyListeners();
  }
}
