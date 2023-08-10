import "dart:io";
import "package:bloc_test/bloc_test.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_test/flutter_test.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:mocktail/mocktail.dart";
import "package:flood_mobile/Blocs/api_bloc/api_bloc.dart";
import "package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart";
import "package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart";
import "package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart";
import "package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart";
import "package:flood_mobile/Blocs/language_bloc/language_bloc.dart";
import "package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart";
import "package:flood_mobile/Blocs/sse_bloc/sse_bloc.dart";
import "package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart";
import "package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart";
import "package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart";
import "package:flood_mobile/Model/notification_model.dart";
import "package:flood_mobile/Model/single_feed_and_response_model.dart";
import "package:flood_mobile/Model/single_rule_model.dart";
import "package:flood_mobile/Model/torrent_model.dart";
import "package:flood_mobile/Pages/home_screen/home_screen.dart";
import "package:flood_mobile/l10n/l10n.dart";

class MockHomeScreenBloc extends MockBloc<HomeScreenEvent, HomeScreenState>
    implements HomeScreenBloc {}

class MockClientSettingsBloc
    extends MockBloc<ClientSettingsEvent, ClientSettingsState>
    implements ClientSettingsBloc {}

void main() {
  late HomeScreenBloc mockHomeScreenBloc;
  late ClientSettingsBloc mockClientSettingsBloc;
  setUpAll(() => HttpOverrides.global = null);
  setUp(() {
    mockHomeScreenBloc = MockHomeScreenBloc();
    mockClientSettingsBloc = MockClientSettingsBloc();
    when(() => mockHomeScreenBloc.state).thenReturn(HomeScreenState(
        torrentList: [
          TorrentModel(
              bytesDone: 0.0,
              dateAdded: 0.0,
              dateCreated: 0.0,
              directory: "test1 directory",
              downRate: 0.0,
              downTotal: 0.0,
              eta: -1,
              hash: 'test1 hash',
              isInitialSeeding: false,
              isPrivate: false,
              isSequential: false,
              message: 'test1 message',
              name: 'test1 name',
              peersConnected: 0.0,
              peersTotal: 0.0,
              percentComplete: 1.1,
              priority: 0.0,
              ratio: 0.0,
              seedsConnected: 0.0,
              seedsTotal: 0.0,
              sizeBytes: 100.0,
              status: ['downloading'],
              tags: ['test1 tags'],
              trackerURIs: ['test1 trackerURIs'],
              upRate: 0.0,
              upTotal: 0.0),
          TorrentModel(
              bytesDone: 0.0,
              dateAdded: 0.0,
              dateCreated: 0.0,
              directory: "test2 directory",
              downRate: 0.0,
              downTotal: 0.0,
              eta: -1,
              hash: 'test2 hash',
              isInitialSeeding: false,
              isPrivate: false,
              isSequential: false,
              message: 'test2 message',
              name: 'test2 name',
              peersConnected: 0.0,
              peersTotal: 0.0,
              percentComplete: 2.2,
              priority: 0.0,
              ratio: 0.0,
              seedsConnected: 0.0,
              seedsTotal: 0.0,
              sizeBytes: 0.0,
              status: ['downloading'],
              tags: ['test2 tags'],
              trackerURIs: ['test2 trackerURIs'],
              upRate: 0.0,
              upTotal: 0.0)
        ],
        torrentListJson: {},
        unreadNotifications: 1,
        notificationModel: NotificationModel(
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
            unread: 1),
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
        downSpeed: '20 Kb/s'));
  });
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>.value(value: LanguageBloc()),
          BlocProvider<UserDetailBloc>.value(value: UserDetailBloc()),
          BlocProvider<HomeScreenBloc>.value(value: mockHomeScreenBloc),
          BlocProvider<ClientSettingsBloc>.value(value: mockClientSettingsBloc),
          BlocProvider<SSEBloc>.value(value: SSEBloc()),
          BlocProvider<ThemeBloc>.value(value: ThemeBloc()),
          BlocProvider<FilterTorrentBloc>.value(value: FilterTorrentBloc()),
          BlocProvider<MultipleSelectTorrentBloc>.value(
              value: MultipleSelectTorrentBloc()),
          BlocProvider<SpeedGraphBloc>.value(value: SpeedGraphBloc()),
          BlocProvider<ApiBloc>.value(value: ApiBloc()),
          BlocProvider<UserInterfaceBloc>.value(value: UserInterfaceBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              locale: Locale('en'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Material(
                child: HomeScreen(themeIndex: 2),
              ),
            );
          },
        ));
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
      expect(find.descendant(of: find.byType(AppBar), matching: find.text("1")),
          findsWidgets);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("Notification Button 2")));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Notification Alert Dialog 2")), findsOneWidget);
      expect(find.text('test status'), findsOneWidget);
      expect(
          find.text(DateTime.fromMillisecondsSinceEpoch(mockHomeScreenBloc
                  .state.notificationModel.notifications[0].ts)
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
      await tester.tap(find.widgetWithText(TextButton, "No"));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Logout AlertDialog")), findsNothing);
    });
  });
}
