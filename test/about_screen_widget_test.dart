import 'dart:io';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Pages/about_screen.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
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
            child: AboutScreen(index: 2),
          ));
        },
      ),
    );
  }

  group("Check different widgets in about-screen", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('App icon asset image')), findsOneWidget);
      expect(find.byKey(Key('release badge key')), findsOneWidget);
      expect(find.byKey(Key('commit badge key')), findsOneWidget);
      expect(find.byKey(Key('build badge key')), findsOneWidget);
      expect(find.byKey(Key('issues badge key')), findsOneWidget);
      expect(find.byKey(Key('PR badge key')), findsOneWidget);
      expect(find.byKey(Key('App info text key')), findsOneWidget);
      expect(find.text('Feedback'), findsOneWidget);
      expect(find.byKey(Key('Feedback text key')), findsOneWidget);
      expect(find.text('More Information'), findsOneWidget);
      expect(find.byKey(Key('More info text key')), findsOneWidget);
    });
  });
}
