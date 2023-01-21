import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  static ThemeData get theme =>
      themeMode == ThemeMode.dark ? MyThemes.darkTheme : MyThemes.lightTheme;

  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff0E2537),
    primaryColorDark: Color(0xff39C481),
    primaryColorLight: Color(0xff305067),
    accentColor: Color(0xff399CF4),
    backgroundColor: Color(0xff305067),
    scaffoldBackgroundColor: Color(0xff305067),
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
    backgroundColor: Color(0xff293341),
    scaffoldBackgroundColor: Colors.grey[300],
    accentColor: Color(0xff399CF4),
    canvasColor: Colors.transparent,
    primaryColorLight: Colors.grey[100],
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
