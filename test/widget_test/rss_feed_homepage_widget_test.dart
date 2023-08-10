import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Blocs/sse_bloc/sse_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/rss_feed_home_page.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class MockHomeScreenBloc extends MockBloc<HomeScreenEvent, HomeScreenState>
    implements HomeScreenBloc {}

void main() {
  late HomeScreenBloc mockHomeScreenBloc;
  setUpAll(() => HttpOverrides.global = null);
  setUp(() {
    mockHomeScreenBloc = MockHomeScreenBloc();
    when(() => mockHomeScreenBloc.state).thenReturn(
      HomeScreenState(
        torrentList: [],
        torrentListJson: {},
        unreadNotifications: 1,
        notificationModel:
            NotificationModel(read: 1, notifications: [], total: 2, unread: 1),
        rssFeedsListJson: {},
        rssFeedsList: [
          FeedsAndRulesModel(
              type: "test feed",
              label: "test label",
              interval: 0,
              id: "test id",
              url: "test url",
              count: 0),
          FeedsAndRulesModel(
              type: "test feed",
              label: "test label",
              interval: 0,
              id: "test id",
              url: "test url",
              count: 0)
        ],
        rssRulesList: [
          RulesModel(
            type: "test rules",
            label: "test label",
            feedIDs: ["test feedIDs"],
            field: "test field",
            tags: ["test tags"],
            match: "test match",
            exclude: "test exclude",
            destination: "test destination",
            id: "test id",
            isBasePath: true,
            startOnLoad: true,
            count: 0,
          )
        ],
        rssFeedsContentsList: [],
        upSpeed: '10 Kb/s',
        downSpeed: '20 Kb/s',
      ),
    );
  });
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDetailBloc>(
          create: (context) => UserDetailBloc(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => mockHomeScreenBloc,
        ),
        BlocProvider<SSEBloc>(
          create: (context) => SSEBloc(),
        ),
        BlocProvider<ClientSettingsBloc>(
          create: (context) => ClientSettingsBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<ApiBloc>(
          create: (context) => ApiBloc(),
        ),
        BlocProvider<LanguageBloc>.value(value: LanguageBloc()),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: RSSFeedHomePage(themeIndex: 2),
        ),
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
        expect(find.text("test label"), findsNWidgets(2));
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
