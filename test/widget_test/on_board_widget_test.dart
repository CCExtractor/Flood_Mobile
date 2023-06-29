import 'package:flood_mobile/Blocs/onboarding_main_page_bloc/on_boarding_page_color_bloc.dart';
import 'package:flood_mobile/Pages/login_screen/login_screen.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/data/onboard_page_data.dart';
import 'package:flood_mobile/Route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/onboarding_main_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('OnboardingMainPage widget test', () {
    late OnBoardingPageColorBloc colorBloc;

    setUp(() {
      colorBloc = OnBoardingPageColorBloc();
    });

    tearDown(() {
      colorBloc.close();
    });

    testWidgets('Onboarding main page test', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<OnBoardingPageColorBloc>.value(
          value: colorBloc,
          child: MaterialApp(
            home: OnboardingMainPage(),
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(SmoothPageIndicator), findsOneWidget);

      // Check initial color
      expect(colorBloc.state, equals(OnBoardingPageColorInitial()));

      // Tap next button and check color change
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(colorBloc.state,
          equals(ColorUpdated(color: onboardData[0].nextAccentColor)));

      // Tap next button and check color change
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(colorBloc.state,
          equals(ColorUpdated(color: onboardData[1].nextAccentColor)));

      // Tap skip button and check navigation to login screen
      await tester.tap(find.byKey(ValueKey('skipButton')));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
