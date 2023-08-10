import 'package:flutter/material.dart';
import 'package:flood_mobile/Model/onboard_page_model.dart';
import 'package:flood_mobile/l10n/l10n.dart';

List<OnboardPageModel> onboardData(BuildContext context) {
  return [
    OnboardPageModel(
      primeColor: Color(0xff293341),
      accentColor: Color(0xff39C481),
      nextAccentColor: Color(0xFFFFE074),
      pageNumber: 0,
      imagePath: 'assets/images/flutter_onboarding_1.png',
      caption: context.l10n.onboarding_screen1_caption,
      subhead: context.l10n.onboarding_screen1_subhead,
      description: context.l10n.onboarding_screen1_description,
    ),
    OnboardPageModel(
      primeColor: Color(0xff39C481),
      accentColor: Color(0xff293341),
      nextAccentColor: Color(0xFFE6E6E6),
      pageNumber: 1,
      imagePath: 'assets/images/flutter_onboarding_2.png',
      caption: context.l10n.onboarding_screen2_caption,
      subhead: context.l10n.onboarding_screen2_subhead,
      description: context.l10n.onboarding_screen2_description,
    ),
    OnboardPageModel(
      primeColor: Color(0xff293341),
      accentColor: Color(0xff39C481),
      nextAccentColor: Color(0xFFE6E6E6),
      pageNumber: 2,
      imagePath: 'assets/images/flutter_onboarding_3.png',
      caption: context.l10n.onboarding_screen3_caption,
      subhead: context.l10n.onboarding_screen3_subhead,
      description: context.l10n.onboarding_screen3_description,
    ),
  ];
}
