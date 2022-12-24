import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/torrent_screen.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/filter_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockHomeProvider extends Mock implements HomeProvider {}

class MockClientSettingsProvider extends Mock
    implements ClientSettingsProvider {}

void main() {
  setUp(() {});
  MockHomeProvider mockHomeProvider = MockHomeProvider();
  MockClientSettingsProvider mockClientSettingsProvider =
      MockClientSettingsProvider();
  when(() => mockClientSettingsProvider.clientSettings).thenReturn(
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
  when(() => mockHomeProvider.torrentList).thenReturn([
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
  ]);

  when(() => mockHomeProvider.upSpeed).thenReturn('test upSpeed');
  when(() => mockHomeProvider.downSpeed).thenReturn('test downSpeed');

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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          print(ThemeProvider.themeMode);
          return MaterialApp(
              home: Material(
            child: TorrentScreen(
              index: 2,
            ),
          ));
        },
      ),
    );
  }

  group("Check different widgets in torrent screen", () {
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
              timestamp: mockHomeProvider.torrentList[0].dateAdded.toInt())),
          findsNWidgets(2));
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('test1 directory'), findsNWidgets(1));
      expect(find.text('Tags'), findsOneWidget);
      expect(find.text('[test1 tags]'), findsOneWidget);
      expect(find.text('Peers'), findsOneWidget);
      expect(find.text('Seeds'), findsOneWidget);
      //for both 'Peers' and 'Seeds'
      expect(
          find.text(mockHomeProvider.torrentList[0].peersConnected
                  .toInt()
                  .toString() +
              ' connected of ' +
              mockHomeProvider.torrentList[0].peersTotal.toInt().toString()),
          findsNWidgets(2));
      expect(find.text('Size'), findsOneWidget);
      // 2 widgets as size is also shown in the torrent tile in the format '0 B / 100 B'
      expect(
          find.text(
              filesize(mockHomeProvider.torrentList[0].sizeBytes.toInt())),
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
      await tester.longPress(find.text('test1 name'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Long Press Torrent Tile Menu')), findsWidgets);
      expect(find.text("Set Tags"), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.tags), findsOneWidget);
      expect(find.text("Check Hash"), findsOneWidget);
      expect(find.byIcon(Icons.tag), findsOneWidget);
      expect(find.text("Delete"), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
      expect(find.text('Delete Torrent'), findsOneWidget);
      expect(find.text('Are you sure you want to delete the torrent?'),
          findsOneWidget);
      expect(find.byKey(Key('Checkbox delete with data')), findsOneWidget);
      expect(find.text('Delete with data'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'No'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Yes'), findsOneWidget);
    });

    testWidgets(
      "Check add torrent widgets",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        expect(find.byKey(Key('Floating Action Button')), findsOneWidget);
        await tester.tap(find.byKey(Key('Floating Action Button')));
        await tester.pumpAndSettle();
        expect(find.byKey(Key('Destination TextField')), findsOneWidget);
        expect(
            find.text(
                mockClientSettingsProvider.clientSettings.directoryDefault),
            findsOneWidget);
        expect(find.text('Use as Base Path'), findsOneWidget);
        expect(find.text('Sequential Download'), findsOneWidget);
        expect(find.text('Completed'), findsOneWidget);
        expect(find.byType(CheckboxListTile), findsNWidgets(3));
        expect(find.byIcon(FontAwesomeIcons.magnet), findsOneWidget);
        expect(find.byIcon(FontAwesomeIcons.solidFile), findsOneWidget);
        expect(
            find.widgetWithText(ElevatedButton, 'Add Torrent'), findsOneWidget);
        expect(find.byIcon(Icons.link), findsNothing);
        expect(find.byKey(Key('Torrent magnet link textfield')), findsNothing);
        await tester.tap(find.byIcon(FontAwesomeIcons.magnet));
        expect(find.byIcon(Icons.paste), findsNothing);
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.link), findsOneWidget);
        expect(
            find.byKey(Key('Torrent magnet link textfield')), findsOneWidget);
        expect(find.byIcon(Icons.paste), findsOneWidget);
      },
    );
  });
}
