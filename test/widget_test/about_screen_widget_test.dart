import 'dart:io';
import 'package:flood_mobile/Pages/about_screen/about_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  setUpAll(() => HttpOverrides.global = null);
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Material(
        child: AboutScreen(themeIndex: 2),
      ),
    );
  }

  group("Check different widgets in about-screen", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetUnderTest());
      });
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
