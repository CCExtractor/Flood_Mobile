import 'dart:io';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Pages/login_screen.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() {});
  setUpAll(() => HttpOverrides.global = null);
  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailProvider>(
          create: (context) => UserDetailProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<SSEProvider>(
          create: (context) => SSEProvider(),
        ),
        ChangeNotifierProvider<ApiProvider>(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider<ClientSettingsProvider>(
          create: (context) => ClientSettingsProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          print(ThemeProvider.themeMode);
          return MaterialApp(
              home: Material(
            child: LoginScreen(),
          ));
        },
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
          tester.firstWidget(urlControllerFinder) as TextFormField;
      expect(urlController.controller?.text, 'http://localhost:3000');
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
  });
}
