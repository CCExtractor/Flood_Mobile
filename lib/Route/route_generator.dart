import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/home_screen/home_screen.dart';
import 'package:flood_mobile/Pages/login_screen/login_screen.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/onboarding_main_screen.dart';
import 'package:flood_mobile/Pages/settings_screen/settings_screen.dart';
import 'package:flood_mobile/Pages/splash_screen/splash_screen.dart';
import 'package:flood_mobile/Pages/torrent_content_screen/torrent_content_screen.dart';
import 'package:flood_mobile/Pages/torrent_screen/torrent_screen.dart';
import 'package:flood_mobile/Pages/video_stream_screen/video_stream_screen.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Route/Arguments/video_stream_screen_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreenRoute:
        final themeIndex = args as int?;
        return MaterialPageRoute(
          builder: (context) => SplashScreen(themeIndex: themeIndex),
        );

      case Routes.loginScreenRoute:
        final themeIndex = args as int?;
        return MaterialPageRoute(
          builder: (context) => LoginScreen(themeIndex: themeIndex),
        );

      case Routes.homeScreenRoute:
        final themeIndex = args as int?;
        return MaterialPageRoute(
          builder: (context) => HomeScreen(themeIndex: themeIndex),
        );

      case Routes.torrentContentScreenRoute:
        return MaterialPageRoute(
          builder: (context) => TorrentContentScreen(
            arguments: args as TorrentContentPageArguments,
          ),
        );

      case Routes.torrnetScreenRoute:
        final themeIndex = args as int?;
        return MaterialPageRoute(
          builder: (context) => TorrentScreen(themeIndex: themeIndex ?? 2),
        );

      case Routes.onboardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => OnboardingMainPage(),
        );

      case Routes.settingsScreenRoute:
        final themeIndex = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(themeIndex: themeIndex),
        );

      case Routes.streamVideoScreenRoute:
        return MaterialPageRoute(
          builder: (context) => VideoStreamScreen(
            args: args as VideoStreamScreenArguments,
          ),
        );

      default:
        final themeIndex = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (context) => LoginScreen(themeIndex: themeIndex),
        );
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoutes(String? val) {
    return [
      MaterialPageRoute(
        builder: (context) => SplashScreen(
          themeIndex: BlocProvider.of<ThemeBloc>(context).isDarkMode ? 2 : 1,
        ),
      )
    ];
  }
}
