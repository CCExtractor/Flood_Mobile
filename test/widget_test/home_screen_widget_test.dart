import "dart:io";
import "package:flood_mobile/Constants/theme_provider.dart";
import "package:flood_mobile/Model/notification_model.dart";
import "package:flood_mobile/Model/single_feed_and_response_model.dart";
import "package:flood_mobile/Model/single_rule_model.dart";
import "package:flood_mobile/Model/torrent_model.dart";
import "package:flood_mobile/Pages/home_screen.dart";
import "package:flood_mobile/Provider/api_provider.dart";
import "package:flood_mobile/Provider/client_provider.dart";
import "package:flood_mobile/Provider/filter_provider.dart";
import "package:flood_mobile/Provider/graph_provider.dart";
import "package:flood_mobile/Provider/home_provider.dart";
import "package:flood_mobile/Provider/multiple_select_torrent_provider.dart";
import "package:flood_mobile/Provider/sse_provider.dart";
import "package:flood_mobile/Provider/user_detail_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:mocktail/mocktail.dart";
import "package:provider/provider.dart";

class MockHomeProvider extends Mock implements HomeProvider {}

class MockClientSettingsProvider extends Mock
    implements ClientSettingsProvider {}

void main() {
  setUp(() {});
  MockHomeProvider mockHomeProvider = MockHomeProvider();
  MockClientSettingsProvider mockClientSettingsProvider =
      MockClientSettingsProvider();
  setUpAll(() => HttpOverrides.global = null);
  when(() => mockHomeProvider.unreadNotifications).thenReturn(0);
  when(() => mockHomeProvider.notificationModel).thenReturn(NotificationModel(
      read: 0,
      notifications: [
        NotificationContentModel(
            identification: "test identification",
            id: "test id",
            name: "test name",
            read: false,
            ts: 0,
            status: "test status")
      ],
      total: 1,
      unread: 1));
  when(() => mockHomeProvider.torrentList).thenReturn([
    TorrentModel(
        bytesDone: 0.0,
        dateAdded: 0.0,
        dateCreated: 0.0,
        directory: "test1 directory",
        downRate: 0.0,
        downTotal: 0.0,
        eta: -1,
        hash: "test1 hash",
        isInitialSeeding: false,
        isPrivate: false,
        isSequential: false,
        message: "test1 message",
        name: "test1 name",
        peersConnected: 0.0,
        peersTotal: 0.0,
        percentComplete: 1.1,
        priority: 0.0,
        ratio: 0.0,
        seedsConnected: 0.0,
        seedsTotal: 0.0,
        sizeBytes: 100.0,
        status: ["downloading"],
        tags: ["test1 tags"],
        trackerURIs: ["test1 trackerURIs"],
        upRate: 0.0,
        upTotal: 0.0),
  ]);

  when(() => mockHomeProvider.rssFeedsList).thenReturn([
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
  ]);
  when(() => mockHomeProvider.rssRulesList).thenReturn([
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
          create: (context) => mockClientSettingsProvider,
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProvider<MultipleSelectTorrentProvider>(
          create: (context) => MultipleSelectTorrentProvider(),
        ),
        ChangeNotifierProvider<GraphProvider>(
          create: (context) => GraphProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          print(ThemeProvider.themeMode);
          return MaterialApp(
              home: Material(
            child: HomeScreen(),
          ));
        },
      ),
    );
  }

  group("Check different widgets in home-screen", () {
    testWidgets("Check top bar widgets", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.ensureVisible(find.byKey(Key("AppBar 1")));
      expect(find.byKey(Key("Menu Icon 1")), findsOneWidget);
      expect(find.byKey(Key("Flood Icon 1")), findsOneWidget);
      expect(find.byKey(Key("Rss Feed Button 1")), findsOneWidget);
      expect(find.byKey(Key("Notification Button 1")), findsOneWidget);

      expect(find.byKey(Key("Rss feed home bottom sheet 1")), findsNothing);
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.ensureVisible(find.byKey(Key("Rss Feed Button 1")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Rss Feed Button 2")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Rss feed home bottom sheet 2")), findsOneWidget);
      expect(find.text("Existing Feeds"), findsOneWidget);
      expect(find.byKey(Key("Feed displayed")), findsNWidgets(2));
    });

    testWidgets("test notification button", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.ensureVisible(find.byKey(Key("Notification Button 1")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Notification Button 2")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Notification Alert Dialog 2")), findsOneWidget);
      expect(find.text('test status'), findsOneWidget);
      expect(
          find.text(DateTime.fromMillisecondsSinceEpoch(
                  mockHomeProvider.notificationModel.notifications[0].ts)
              .toString()),
          findsOneWidget);
      expect(find.text('test name'), findsOneWidget);
      expect(find.text('Clear All'), findsOneWidget);
    });

    testWidgets("Check menu button working", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.ensureVisible(find.byKey(Key("Menu Icon 1")));
      await tester.tap(find.byKey(Key("Menu Icon 2")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Flood Icon menu 1")), findsOneWidget);
      expect(find.byKey(Key("Release Shield 1")), findsOneWidget);
      expect(find.byKey(Key("Change Theme Button")), findsNWidgets(2));
      expect(find.byIcon(Icons.wb_sunny_rounded), findsNWidgets(2));
      expect(find.byIcon(Icons.mode_night_rounded), findsNothing);
      await tester.tap(find.byKey(Key("Change Theme Button")).first);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.dashboard), findsNWidgets(2));
      expect(find.text("Torrents"), findsNWidgets(2));
      expect(find.byIcon(Icons.settings), findsNWidgets(2));
      expect(find.text("Settings"), findsNWidgets(2));
      expect(find.byIcon(Icons.exit_to_app), findsNWidgets(2));
      expect(find.text("Logout"), findsNWidgets(2));
      expect(find.byIcon(FontAwesomeIcons.github), findsNWidgets(2));
      expect(find.text("GitHub"), findsNWidgets(2));
      expect(find.byIcon(Icons.info), findsNWidgets(2));
      expect(find.text("About"), findsNWidgets(2));

      await tester.tap(find.byIcon(Icons.exit_to_app).last,
          warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Logout AlertDialog")), findsOneWidget);
      expect(find.text("Are you sure you want to\n Log out ?"), findsOneWidget);
      expect(find.widgetWithText(TextButton, "No"), findsOneWidget);
      expect(find.widgetWithText(TextButton, "Yes"), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  });
}
