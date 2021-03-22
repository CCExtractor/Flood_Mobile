import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';

import 'Pages/torrent_screen.dart';
import 'Route/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.primaryColor,
        accentColor: AppColor.accentColor,
      ),
      initialRoute: Routes.splashScreenRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
