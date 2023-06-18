import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Blocs/sse_bloc/sse_bloc.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Model/graph_model.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/torrent_screen/torrent_screen.dart';
import 'package:flood_mobile/Pages/torrent_screen/services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';

class MockHomeScreenBloc extends MockBloc<HomeScreenEvent, HomeScreenState>
    implements HomeScreenBloc {}

class MockClientSettingsBloc
    extends MockBloc<ClientSettingsEvent, ClientSettingsState>
    implements ClientSettingsBloc {}

class MockSpeedGraphBloc extends MockBloc<SpeedGraphEvent, SpeedGraphState>
    implements SpeedGraphBloc {}

void main() {
  late SpeedGraphBloc mockSpeedGraphBloc;
  late HomeScreenBloc mockHomeScreenBloc;
  late ClientSettingsBloc mockClientSettingsBloc;

  tearDown(() {
    mockSpeedGraphBloc.close();
    mockHomeScreenBloc.close();
    mockClientSettingsBloc.close();
  });
  setUp(() {
    mockSpeedGraphBloc = MockSpeedGraphBloc();
    mockHomeScreenBloc = MockHomeScreenBloc();
    mockClientSettingsBloc = MockClientSettingsBloc();
    when(() => mockClientSettingsBloc.clientSettings).thenReturn(
        ClientSettingsModel(
            dht: false,
            dhtPort: 0,
            directoryDefault: 'test directory',
            networkHttpMaxOpen: 0,
            networkLocalAddress: ['test networkLocalAddress'],
            networkMaxOpenFiles: 0,
            networkPortOpen: false,
            networkPortRandom: false,
            networkPortRange: 'test networkPortRange',
            piecesHashOnCompletion: false,
            piecesMemoryMax: 0,
            protocolPex: false,
            throttleGlobalDownSpeed: 0,
            throttleGlobalUpSpeed: 0,
            throttleMaxDownloads: 0,
            throttleMaxDownloadsGlobal: 0,
            throttleMaxPeersNormal: 0,
            throttleMaxPeersSeed: 0,
            throttleMaxUploads: 0,
            throttleMaxUploadsGlobal: 0,
            throttleMinPeersNormal: 0,
            throttleMinPeersSeed: 0,
            trackersNumWant: 0));

    when(() => mockSpeedGraphBloc.state).thenReturn(SpeedGraphState(
        uploadGraphData: List<GraphModel>.generate(
          30,
          ((index) {
            return GraphModel(speed: 0, second: index + 1);
          }),
        ),
        downloadGraphData: List<GraphModel>.generate(
          30,
          ((index) {
            return GraphModel(speed: 0, second: index + 1);
          }),
        ),
        fakeTime: 31,
        showChart: true));
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
        downSpeed: '20 Kb/s'));
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDetailBloc>.value(value: UserDetailBloc()),
        BlocProvider<HomeScreenBloc>.value(value: mockHomeScreenBloc),
        BlocProvider<SSEBloc>.value(value: SSEBloc()),
        BlocProvider<ClientSettingsBloc>.value(value: mockClientSettingsBloc),
        BlocProvider<ThemeBloc>.value(value: ThemeBloc()),
        BlocProvider<FilterTorrentBloc>.value(value: FilterTorrentBloc()),
        BlocProvider<MultipleSelectTorrentBloc>.value(
            value: MultipleSelectTorrentBloc()),
        BlocProvider<ApiBloc>.value(value: ApiBloc()),
        BlocProvider<SpeedGraphBloc>.value(value: mockSpeedGraphBloc),
        BlocProvider<LanguageBloc>.value(value: LanguageBloc()),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: TorrentScreen(themeIndex: 2),
        ),
      ),
    );
  }

  group("Check different widgets in torrent screen", () {
    testWidgets(
      "Check PullToRevealTopItemList widget",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.drag(
          find.byType(TorrentScreen),
          Offset(0, 300),
        );
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.arrow_upward_rounded), findsOneWidget);
        expect(find.text('10 Kb/s'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_downward_rounded), findsOneWidget);
        expect(find.text('20 Kb/s'), findsOneWidget);
        expect(find.byKey(Key("Show Chart Button")), findsOneWidget);
        await tester.tap(find.byKey(Key("Show Chart Button")));
        await tester.pumpAndSettle();
        expect(find.byKey(Key("Speed Graph")), findsOneWidget);
        expect(find.byKey(Key('Search Torrent TextField')), findsOneWidget);
        final torrentControllerFinder =
            find.byKey(Key('Search Torrent TextField'));
        expect(
          find.descendant(
            of: torrentControllerFinder,
            matching: find.text('Search Torrent'),
          ),
          findsOneWidget,
        );
        final filterChipFinder = find.byKey(Key('Filter Torrent ActionChip'));
        expect(filterChipFinder, findsOneWidget);
        expect(
          find.descendant(
            of: filterChipFinder,
            matching: find.byIcon(Icons.filter_list_alt),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: filterChipFinder,
            matching: find.text('all'),
          ),
          findsOneWidget,
        );
        await tester.tap(filterChipFinder);
        await tester.pumpAndSettle();
        expect(
            find.byKey(Key("Filter By Status Bottom Sheet")), findsOneWidget);

        // Filter by status bottom sheet
        expect(find.text('Filter by status'), findsOneWidget);
        // All torrent filter option
        expect(find.byIcon(Icons.star_sharp), findsOneWidget);
        expect(find.text("All"), findsNWidgets(3));
        expect(tester.widget<Text>(find.text("All").first).style!.color,
            equals(Colors.blue));
        // Downloading torrent filter option
        expect(find.byIcon(Icons.download_sharp), findsOneWidget);
        expect(find.byKey(Key("Downloading Torrent ListTile")), findsOneWidget);
        // Seeding torrent filter option
        expect(find.byIcon(Icons.upload_sharp), findsOneWidget);
        expect(find.byKey(Key("Seeding Torrent ListTile")), findsOneWidget);
        // Completed torrent filter option
        expect(find.byIcon(Icons.done), findsOneWidget);
        expect(find.byKey(Key("Complete Torrent ListTile")), findsOneWidget);
        // Stopped torrent filter option
        expect(find.byIcon(Icons.stop), findsNWidgets(3));
        expect(find.byKey(Key("Stopped Torrent ListTile")), findsOneWidget);
        // Active torrent filter option
        expect(find.byIcon(Icons.trending_up_outlined), findsOneWidget);
        expect(find.byKey(Key("Active Torrent ListTile")), findsOneWidget);
        // Inactive torrent filter option
        expect(find.byIcon(Icons.trending_down_outlined), findsOneWidget);
        expect(find.byKey(Key("Inactive Torrent ListTile")), findsOneWidget);
        // Error torrent filter option
        expect(find.byIcon(Icons.error), findsOneWidget);
        expect(find.byKey(Key("Error Torrent ListTile")), findsOneWidget);
        expect(find.text('Filter by tags'), findsOneWidget);
        expect(find.text('Filter by trackers'), findsOneWidget);
      },
    );
    testWidgets("Check torrent tile", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('test1 name'), findsOneWidget);
      expect(find.text('test2 name'), findsOneWidget);
      expect(find.byKey(Key('Linear Progress Indicator')), findsNWidgets(2));
      expect(find.text('1.1 %'), findsOneWidget);
      expect(find.text('2.2 %'), findsOneWidget);
      expect(find.byKey(Key('status widget')), findsNWidgets(2));
      expect(find.byKey(Key('eta widget')), findsNWidgets(2));
      expect(find.byKey(Key('download done data widget')), findsNWidgets(2));
      expect(find.byIcon(Icons.stop), findsNWidgets(2));
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsNWidgets(2));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets("Check torrent more info widgets", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('test1 name'));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_up_rounded), findsNWidgets(1));
      expect(find.text('Date Added'), findsOneWidget);
      expect(find.text('Date Created'), findsOneWidget);
      //for both 'Date Added' and 'Date Created'
      expect(
          find.text(dateConverter(
              timestamp:
                  mockHomeScreenBloc.state.torrentList[0].dateAdded.toInt())),
          findsNWidgets(2));
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('test1 directory'), findsNWidgets(1));
      expect(find.text('Tags'), findsOneWidget);
      expect(find.text('[test1 tags]'), findsOneWidget);
      expect(find.text('Peers'), findsOneWidget);
      expect(find.text('Seeds'), findsOneWidget);
      //for both 'Peers' and 'Seeds'
      expect(
          find.text(mockHomeScreenBloc.state.torrentList[0].peersConnected
                  .toInt()
                  .toString() +
              ' connected of ' +
              mockHomeScreenBloc.state.torrentList[0].peersTotal
                  .toInt()
                  .toString()),
          findsNWidgets(2));
      expect(find.text('Size'), findsOneWidget);
      // 2 widgets as size is also shown in the torrent tile in the format '0 B / 100 B'
      expect(
          find.text(filesize(
              mockHomeScreenBloc.state.torrentList[0].sizeBytes.toInt())),
          findsNWidgets(2));
      expect(find.text('Type'), findsOneWidget);
      expect(find.text('Public'), findsOneWidget);
      expect(find.byKey(Key('Files button')), findsOneWidget);
      expect(find.byIcon(Icons.file_copy_rounded), findsOneWidget);
    });

    testWidgets("Check delete torrent button", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.drag(find.text('test1 name'), const Offset(-1500.0, 0.0));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets("Check long press torrent tile options",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      //Test select torrent option
      await tester.longPress(find.text('test1 name'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Long Press Torrent Tile Menu')), findsWidgets);
      expect(find.text("Select Torrent"), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.solidFile), findsOneWidget);
      expect(find.text("Check Hash"), findsOneWidget);
      expect(find.byIcon(Icons.tag), findsOneWidget);

      // Test set tags option
      expect(find.text("Set Tags"), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.tags), findsOneWidget);
      await tester.tap(find.byIcon(FontAwesomeIcons.tags));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("Add Tag AlertDialog")), findsOneWidget);
      expect(find.byKey(Key('Set Tags Text')), findsOneWidget);
      expect(find.byKey(Key('Tags Text Form Field')), findsOneWidget);
      final tagControllerFinder = find.byKey(Key('Tags Text Form Field'));
      var tagController =
          tester.firstWidget(tagControllerFinder) as TextFormField;
      expect(tagController.controller?.text, 'test1 tags');
      await tester.enterText(tagControllerFinder, 'Tag1,Tag2,Tag3');
      expect(find.byKey(Key('Show Arrow Down Icon')), findsOneWidget);
      expect(find.byKey(Key('Show Arrow Up Icon')), findsNothing);
      await tester.ensureVisible(find.byKey(Key('Show Arrow Down Icon')));
      await tester.tap(find.byKey(Key('Show Arrow Down Icon')),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(
          find.byKey(
            Key('Tags List Container'),
          ),
          findsOneWidget);
      await tester.tap(find.byType(TextButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);

      // Test delete option
      await tester.longPress(find.text('test2 name'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Long Press Torrent Tile Menu')), findsWidgets);
      expect(find.text("Delete"), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Delete Torrent'), findsOneWidget);
      expect(find.text('Are you sure you want to delete the torrent?'),
          findsOneWidget);
      expect(find.byKey(Key('Checkbox delete with data')), findsOneWidget);
      expect(find.text('Delete with data'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'No'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Yes'), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'No'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsNothing);
    });

    testWidgets(
      "Check add torrent widgets",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.byKey(Key('Floating Action Button')), findsOneWidget);
        await tester.tap(find.byKey(Key('Floating Action Button')));
        await tester.pumpAndSettle();
        expect(find.byIcon(FontAwesomeIcons.solidFile), findsOneWidget);
        expect(find.byIcon(FontAwesomeIcons.magnet), findsOneWidget);
        await tester.tap(find.byIcon(FontAwesomeIcons.magnet));
        await tester.pumpAndSettle();
        expect(find.text('Selected Magnet Link'), findsOneWidget);
        expect(find.byKey(Key('MagnetUrl TextFormField')), findsOneWidget);
        expect(find.byIcon(Icons.link), findsOneWidget);
        expect(find.byIcon(Icons.paste), findsOneWidget);
        expect(find.byKey(Key('Destination TextFormField')), findsOneWidget);
        expect(
            find.text(mockClientSettingsBloc.clientSettings.directoryDefault),
            findsOneWidget);
        expect(find.byIcon(Icons.folder), findsOneWidget);
        expect(find.byType(CheckboxListTile), findsNWidgets(3));
        expect(find.text('Use as Base Path'), findsOneWidget);
        expect(find.text('Sequential Download'), findsOneWidget);
        expect(find.text('Completed'), findsOneWidget);
        expect(
            find.widgetWithText(ElevatedButton, 'Add Torrent'), findsOneWidget);
      },
    );
  });
}
