import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Route/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primaryColor,
          accentColor: AppColor.accentColor,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
