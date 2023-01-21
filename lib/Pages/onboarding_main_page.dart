import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/onboarding/onboarding.dart';
import '../Provider/color_provider.dart';

class OnboardingMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => ColorProvider(),
        child: Onboarding(),
      ),
    );
  }
}
