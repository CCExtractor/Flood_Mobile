import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/bloc_provider_list.dart';
import 'package:flood_mobile/Pages/about_screen/about_screen.dart';
import 'package:flood_mobile/l10n/l10n.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  setUpAll(() => HttpOverrides.global = null);
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: BlocProviders.multiBlocProviders,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: AboutScreen(themeIndex: 2),
        ),
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
