import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Notifications/notification_controller.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Notifications/notification_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flood_mobile/Route/route_generator.dart';
import 'package:flood_mobile/Blocs/bloc_provider_list.dart';
import 'package:flood_mobile/l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = SimpleBlocObserver(); //optional: enable for debugging purpose
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  await AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher', notificationChannelsList,
      channelGroups: notificationChannelsGroupList);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await ThemeBloc().getPreviousTheme();
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
    return MultiBlocProvider(
      providers: BlocProviders.multiBlocProviders,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          BlocProvider.of<LanguageBloc>(context, listen: false)
              .add(GetPreviousLanguageEvent());
          return KeyboardDismissOnTap(
            child: MaterialApp(
              locale: state.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Flood Mobile',
              onGenerateInitialRoutes: RouteGenerator.onGenerateInitialRoutes,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
