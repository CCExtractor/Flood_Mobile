import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  static ThemeData get theme =>
      themeMode == ThemeMode.dark ? MyThemes.darkTheme : MyThemes.lightTheme;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff0E2537),
    primaryColorDark: Color(0xff39C481),
    accentColor: Color(0xff399CF4),
    backgroundColor: Color(0xff305067),
    textTheme: TextTheme().apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    canvasColor: Colors.transparent,
    dialogBackgroundColor: Color(0xff2A3342),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorDark: Color(0xff39C481),
    accentColor: Color(0xff399CF4),
    canvasColor: Colors.transparent,
    backgroundColor: Color(0xffE9EEF2),
    dialogBackgroundColor: Color(0xff399CF4),
    textTheme: TextTheme().apply(
      displayColor: Color(0xff293341),
      bodyColor: Color(0xff293341),
    ),
    primaryTextTheme: TextTheme().apply(
      displayColor: Color(0xff293341),
      bodyColor: Color(0xff293341),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );
}
