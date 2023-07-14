import 'dart:async';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc_event.dart';
import 'package:flood_mobile/Blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final int? themeIndex;

  const SplashScreen({Key? key, this.themeIndex}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int themeIndex;
  @override
  void initState() {
    super.initState();
    themeIndex = widget.themeIndex ?? 2;
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
      BlocProvider.of<UserDetailBloc>(context, listen: false)
          .add(SetUserDetailsEvent(token: token, username: username));
      BlocProvider.of<ApiBloc>(context, listen: false)
          .add(SetBaseUrlEvent(url: baseUrl));
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.homeScreenRoute, (Route<dynamic> route) => false,
          arguments: themeIndex);
    }
    if (token == '' &&
        baseUrl == '' &&
        username == '' &&
        loggedInBefore == false) {
      BlocProvider.of<LoginScreenBloc>(context, listen: false)
          .add(SetLoggedInStatusEvent(loggedIn: true));
      Navigator.of(context).pushNamed(Routes.onboardingScreenRoute);
    }
    if (token == '' &&
        baseUrl == '' &&
        username == '' &&
        loggedInBefore == true) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginScreenRoute, (Route<dynamic> route) => false,
          arguments: themeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ThemeBloc.theme(themeIndex).primaryColor,
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
