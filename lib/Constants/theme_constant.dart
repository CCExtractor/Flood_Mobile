import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff0E2537),
    primaryColorDark: Color(0xff39C481),
    primaryColorLight: Color(0xff305067),
    scaffoldBackgroundColor: Color(0xff305067),
    textTheme: TextTheme().apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    colorScheme: ThemeData(brightness: Brightness.dark).colorScheme.copyWith(
          secondary: Color(0xff399CF4),
          background: Color(0xff305067),
          error: Color(0xffF34570),
        ),
    canvasColor: Colors.transparent,
    dialogBackgroundColor: Color(0xff2A3342),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    highlightColor: Color(0xff415062),
    disabledColor: Colors.white38,
    dividerColor: Colors.white12,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorDark: Color(0xff39C481),
    scaffoldBackgroundColor: Colors.grey[300],
    colorScheme: ThemeData(brightness: Brightness.light).colorScheme.copyWith(
          secondary: Color(0xff399CF4),
          background: Color(0xff293341),
          error: Color(0xffF34570),
        ),
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
    highlightColor: Color(0xff415062),
    disabledColor: Colors.black38,
    dividerColor: Colors.black12,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
}
