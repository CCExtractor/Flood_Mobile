import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:wetalk/config/palette.dart';
import 'package:wetalk/screens/auth/register.dart';
import 'package:wetalk/screens/auth/sign_in.dart';
import 'package:wetalk/screens/background_painter.dart';
import 'package:wetalk/screens/home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LitAuth.custom(
        errorNotification: const NotificationConfig(
          backgroundColor: Palette.darkBlue,
          icon: Icon(
            Icons.error_outline,
            color: Colors.deepOrange,
            size: 32,
          ),
        ),
        /*   successNotification: const NotificationConfig(
          backgroundColor: Palette.darkBlue,
          icon: Icon(
            Icons.error_outline,
            color: Colors.deepOrange,
            size: 32,
          ),
        ),*/
        onAuthSuccess: () {
          Navigator.of(context).pushReplacement(HomeScreen.route);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return SizedBox.expand(
                      child: PageTransitionSwitcher(
                        reverse: !value,
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            fillColor: Colors.transparent,
                            child: child,
                          );
                        },
                        child: value
                            ? SignIn(
                                key: const ValueKey('SignIn'),
                                onRegisterClicked: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = false;
                                  _controller.forward();
                                },
                              )
                            : Register(
                                key: const ValueKey('Register'),
                                onSignInPressed: () {
                                  context.resetSignInForm();
                                  showSignInPage.value = true;
                                  _controller.reverse();
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
