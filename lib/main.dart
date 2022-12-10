import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/login_status_data_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'Provider/color_provider.dart';
import 'Constants/notification_keys.dart';
import 'Pages/home_screen.dart';
import 'Provider/filter_provider.dart';
import 'Route/route_generator.dart';
import 'Route/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: NotificationConstants.DOWNLOADS_CHANNEL_KEY,
        channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY1,
        channelName: 'Downloads Channel',
        channelDescription:
            'Notification channel for displaying torrent downloads',
        defaultColor: Color(0xff0E2537),
        ledColor: Colors.white,
        playSound: true,
        enableVibration: true,
        locked: true,
      ),
      NotificationChannel(
        channelKey: NotificationConstants.PUSH_NOTIFICATION_CHANNEL_KEY,
        channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY2,
        channelName: 'Push Notification Channel',
        channelDescription:
            'Notification channel for displaying push notifications',
        defaultColor: Color(0xff0E2537),
        ledColor: Colors.white,
        playSound: true,
        enableVibration: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupName: 'Download Channel',
          channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY1),
      NotificationChannelGroup(
          channelGroupName: 'Push Notification Channel',
          channelGroupKey: NotificationConstants.CHANNEL_GROUP_KEY2),
    ],
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailProvider>(
          create: (context) => UserDetailProvider(),
        ),
        ChangeNotifierProvider<LoginStatusDataProvider>(
          create: (context) => LoginStatusDataProvider(),
        ),
        ChangeNotifierProvider<ColorProvider>(
          create: (context) => ColorProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<SSEProvider>(
          create: (context) => SSEProvider(),
        ),
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<ClientSettingsProvider>(
          create: (context) => ClientSettingsProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          print(ThemeProvider.themeMode);
          return KeyboardDismissOnTap(
            child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: ThemeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              initialRoute: Routes.splashScreenRoute,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
