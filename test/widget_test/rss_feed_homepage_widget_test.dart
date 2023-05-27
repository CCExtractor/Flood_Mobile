import 'dart:io';

import 'package:flood_mobile/Components/RSSFeedHomePage.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:provider/provider.dart';

class MockHomeProvider extends Mock implements HomeProvider {}

void main() {
  setUp(() {});
  setUpAll(() => HttpOverrides.global = null);
  MockHomeProvider mockHomeProvider = MockHomeProvider();
  when(() => mockHomeProvider.rssFeedsList).thenReturn([
    FeedsAndRulesModel(
        type: 'test feed',
        label: 'test label',
        interval: 0,
        id: 'test id',
        url: 'test url',
        count: 0),
    FeedsAndRulesModel(
        type: 'test feed',
        label: 'test label',
        interval: 0,
        id: 'test id',
        url: 'test url',
        count: 0)
  ]);
  when(() => mockHomeProvider.rssRulesList).thenReturn([
    RulesModel(
      type: 'test rules',
      label: 'test label',
      feedIDs: ['test feedIDs'],
      field: 'test field',
      tags: ['test tags'],
      match: 'test match',
      exclude: 'test exclude',
      destination: 'test destination',
      id: 'test id',
      isBasePath: true,
      startOnLoad: true,
      count: 0,
    )
  ]);

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetailProvider>(
          create: (context) => UserDetailProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => mockHomeProvider,
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
              home: Scaffold(
            body: RSSFeedHomePage(index: 2),
          ));
        },
      ),
    );
  }

  testWidgets(
    "Tabs titles are displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Feeds Tab')), findsOneWidget);
      expect(find.byKey(Key('Download Rules Tab')), findsOneWidget);
      await tester.pumpAndSettle();
    },
  );

  group("Check Feeds Tab", () {
    testWidgets(
      "Existing feeds are displayed",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.text('Existing Feeds'), findsOneWidget);
        expect(
            find.byKey(
              Key('No existing feeds displaying container'),
            ),
            findsNothing);
        expect(find.byKey(Key("Feeds are fetched")), findsOneWidget);
        expect(find.byKey(Key("Feed displayed")), findsNWidgets(2));
        expect(find.text("test label"), findsNWidgets(4));
        expect(find.text("0 matches"), findsNWidgets(2));
        expect(find.text("0 Minutes"), findsNWidgets(2));
        expect(find.text("test url"), findsNWidgets(2));
        expect(find.byIcon(Icons.edit), findsNWidgets(2));
        expect(find.byIcon(Icons.delete), findsNWidgets(2));
        await tester.tap(find.byIcon(Icons.delete).first);
        await tester.pumpAndSettle();
        expect(find.text("Feed deleted successfully"), findsWidgets);
        await tester.tap(find.text("Dismiss").first);
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      "Check adding new feed widgets",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.text('New'), findsOneWidget);
        expect(find.byKey(Key('Label textformfield')), findsNothing);
        expect(find.byKey(Key('Interval textformfield')), findsNothing);
        expect(find.byKey(Key('Interval type dropdown')), findsNothing);
        expect(find.byKey(Key('Url textformfield')), findsNothing);
        expect(find.byKey(Key('Url paste icon')), findsNothing);
        expect(find.text('Cancel'), findsNothing);
        expect(find.text('Save'), findsNothing);
        await tester.tap(find.text('New'));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('Label textformfield')), findsOneWidget);
        expect(find.byKey(Key('Interval textformfield')), findsOneWidget);
        expect(find.byKey(Key('Interval type dropdown')), findsOneWidget);
        expect(find.byKey(Key('Url textformfield')), findsOneWidget);
        expect(find.byKey(Key('Url paste icon')), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Save'), findsOneWidget);
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      "Check browse feeds widgets",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.text('Browse Feeds'), findsOneWidget);
        expect(find.byKey(Key('Browse feeds dropdown')), findsOneWidget);
        await tester.pumpAndSettle();
      },
    );
  });

  group("Check Download Rules Tab", () {
    testWidgets(
      "Check existing rules are displayed",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.tap(find.text('Download Rules'));
        await tester.pumpAndSettle();
        expect(find.text('Existing Rules'), findsOneWidget);
        expect(find.byKey(Key('No rules defined')), findsNothing);
        expect(find.byKey(Key("Rules Displayed")), findsOneWidget);
        expect(find.text('test label'), findsOneWidget);
        expect(find.text('0 matches'), findsOneWidget);
        expect(find.text('Tags: test tags'), findsOneWidget);
        expect(find.text('Match: test match'), findsOneWidget);
        expect(find.text('Exclude: test exclu...'), findsOneWidget);
        expect(find.byIcon(Icons.edit), findsOneWidget);
        expect(find.byIcon(Icons.delete), findsOneWidget);
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();
        expect(find.text('Rule deleted successfully'), findsOneWidget);
        await tester.tap(find.text('Dismiss'));
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      "Check adding new rules widgets",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.tap(find.text('Download Rules'));
        await tester.pumpAndSettle();
        expect(find.text('New'), findsOneWidget);
        expect(find.byKey(Key('Rules label textformfield')), findsNothing);
        expect(find.byKey(Key('applicable feed dropdown')), findsNothing);
        expect(find.byKey(Key('Match pattern textformfield')), findsNothing);
        expect(find.byKey(Key('Exclude pattern textformfield')), findsNothing);
        expect(
            find.byKey(Key('Torrent destination textformfield')), findsNothing);
        expect(find.byKey(Key('Apply tags textformfield')), findsNothing);
        expect(find.byKey(Key('use as base path filterchip')), findsNothing);
        expect(find.byKey(Key('starts on load filterchip')), findsNothing);
        expect(find.text('Cancel'), findsNothing);
        expect(find.text('Save'), findsNothing);
        await tester.tap(find.text('New'));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('Rules label textformfield')), findsOneWidget);
        expect(find.byKey(Key('applicable feed dropdown')), findsOneWidget);
        expect(find.byKey(Key('Match pattern textformfield')), findsOneWidget);
        expect(find.byKey(Key('Torrent destination textformfield')),
            findsOneWidget);
        expect(find.byKey(Key('Apply tags textformfield')), findsOneWidget);
        expect(find.byKey(Key('use as base path filterchip')), findsOneWidget);
        expect(find.byKey(Key('starts on load filterchip')), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Save'), findsOneWidget);
        await tester.pumpAndSettle();
      },
    );
  });
}
