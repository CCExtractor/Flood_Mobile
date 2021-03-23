import 'package:flood_mobile/Pages/home_screen.dart';
import 'package:flood_mobile/Pages/login_screen.dart';
import 'package:flood_mobile/Pages/splash_screen.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case Routes.loginScreenRoute:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;
      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (context) => HomeScreen());
        break;
    }
  }
}
