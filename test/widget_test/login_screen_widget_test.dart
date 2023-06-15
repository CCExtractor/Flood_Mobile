import 'dart:io';
import 'package:flood_mobile/Blocs/bloc_provider_list.dart';
import 'package:flood_mobile/Pages/login_screen/login_screen.dart';
import 'package:flood_mobile/Pages/login_screen/widgets/login_screen_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  setUpAll(() => HttpOverrides.global = null);
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: BlocProviders.multiBlocProviders,
      child: MaterialApp(
        home: Material(
          child: LoginScreen(),
        ),
      ),
    );
  }

  group("Check different widgets in login-screen", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Flood Icon')), findsOneWidget);
      expect(find.text('Welcome to Flood'), findsOneWidget);
      expect(find.text('Sign in to your account'), findsOneWidget);
      expect(find.byKey(Key('Url TextField')), findsOneWidget);
      expect(find.byIcon(Icons.link), findsOneWidget);
      expect(find.byIcon(Icons.paste), findsOneWidget);
      final urlControllerFinder = find.byKey(Key('Url TextField'));
      var urlController =
          tester.firstWidget(urlControllerFinder) as LoginScreenTextField;
      expect(urlController.controller.text, 'http://localhost:3000');
      expect(find.byKey(Key('Username TextField')), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.byKey(Key('Password TextField')), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
      expect(find.byKey(Key('Github Icon key')), findsOneWidget);
    });

    testWidgets("Check if validators working correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byKey(Key('Url TextField')), '');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Field cannot be empty'), findsNWidgets(3));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('Url TextField')), 'test url');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Field cannot be empty'), findsNWidgets(2));
      await tester.enterText(
          find.byKey(Key('Username TextField')), 'test username');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Field cannot be empty'), findsNWidgets(1));
      await tester.enterText(
          find.byKey(Key('Password TextField')), 'test password');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
      expect(find.text('Field cannot be empty'), findsNWidgets(0));
    });
  });
}
