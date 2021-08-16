import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flutter/cupertino.dart';

class ClientSettingsProvider extends ChangeNotifier {
  late ClientSettingsModel clientSettings;

  void setClientSettings(newClientSettings) {
    clientSettings = newClientSettings;
    notifyListeners();
  }
}
