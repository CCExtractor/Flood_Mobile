import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import 'Route/route_generator.dart';
import 'Route/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailProvider>(
          create: (context) => UserDetailProvider(),
        ),
      ],
      child: KeyboardDismissOnTap(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            primaryColor: AppColor.primaryColor,
            accentColor: AppColor.accentColor,
          ),
          initialRoute: Routes.splashScreenRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
