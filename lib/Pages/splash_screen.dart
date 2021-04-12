import 'dart:async';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer(const Duration(seconds: 2), onEnd);
  }

  Future<void> onEnd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('floodToken') ?? '';
    print('Token: ' + token);
    if (token != '') {
      Provider.of<UserDetailProvider>(context, listen: false).setToken(token);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.homeScreenRoute, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginScreenRoute, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColor.primaryColor,
      child: Center(
        child: Image(
          image: AssetImage(
            'assets/images/icon.png',
          ),
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
