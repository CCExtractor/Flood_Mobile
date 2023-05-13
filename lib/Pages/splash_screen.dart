import 'dart:async';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Pages/onboarding_main_page.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/login_status_data_provider.dart';
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
    super.initState();
    new Timer(const Duration(seconds: 2), onEnd);
  }

  Future<void> onEnd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedInBefore = prefs.getBool('loggedInData') ?? false;
    String token = prefs.getString('floodToken') ?? '';
    print('Token: ' + token);
    String baseUrl = prefs.getString('baseUrl') ?? '';
    String username = prefs.getString('floodUsername') ?? '';
    if (token != '' &&
        baseUrl != '' &&
        username != '' &&
        loggedInBefore == true) {
      Provider.of<UserDetailProvider>(context, listen: false).setUserDetails(
        token,
        username,
      );
      Provider.of<ApiProvider>(context, listen: false).setBaseUrl(baseUrl);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.homeScreenRoute, (Route<dynamic> route) => false);
    }
    if (token == '' &&
        baseUrl == '' &&
        username == '' &&
        loggedInBefore == false) {
      Provider.of<LoginStatusDataProvider>(context, listen: false)
          .setLoggedInStatus(true);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnboardingMainPage()));
    }
    if (token == '' &&
        baseUrl == '' &&
        username == '' &&
        loggedInBefore == true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginScreenRoute, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ThemeProvider.theme.primaryColor,
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
