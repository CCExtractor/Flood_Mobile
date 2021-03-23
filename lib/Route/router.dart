import 'package:auto_route/annotations.dart';
import 'package:flood_mobile/Pages/login_screen.dart';
import 'package:flood_mobile/Pages/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginScreen),
  ],
)
class $AppRouter {}
