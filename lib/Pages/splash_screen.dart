import 'dart:async';

import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

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
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.loginScreenRoute, (Route<dynamic> route) => false);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('token');
    // print('Token: ' + token);
    // if (token != null && token != '') {
    //   Provider.of<AuthProvider>(context, listen: false)
    //       .changeGuestStatus(false);
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       homePageRoute, (Route<dynamic> route) => false);
    // } else {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //       onboardingRoute, (Route<dynamic> route) => false);
    //   // Navigator.of(context).pushReplacement(
    //   //   new PageRouteBuilder(
    //   //     maintainState: true,
    //   //     opaque: true,
    //   //     pageBuilder: (context, _, __) => OnboardingPage(),
    //   //     transitionDuration: const Duration(seconds: 1),
    //   //     transitionsBuilder: (context, anim1, anim2, child) {
    //   //       return new FadeTransition(
    //   //         child: child,
    //   //         opacity: anim1,
    //   //       );
    //   //     },
    //   //   ),
    //   // );
    // }
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
