// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../Pages/login_screen.dart' as _i3;
import '../Pages/splash_screen.dart' as _i2;
import '../Pages/torrent_screen.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.SplashScreen());
    },
    LoginRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.LoginScreen());
    },
    TorrentRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i4.TorrentScreen());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-screen'),
        _i1.RouteConfig(TorrentRoute.name, path: '/torrent-screen')
      ];
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-screen');

  static const String name = 'LoginRoute';
}

class TorrentRoute extends _i1.PageRouteInfo {
  const TorrentRoute() : super(name, path: '/torrent-screen');

  static const String name = 'TorrentRoute';
}
