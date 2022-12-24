import 'dart:math';

import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Pages/settings_screen.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
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
  MockClientSettingsProvider mockClientSettingsProvider =
      MockClientSettingsProvider();
  when(() => mockClientSettingsProvider.clientSettings).thenReturn(
      ClientSettingsModel(
          dht: false,
          dhtPort: 1,
          directoryDefault: 'test directory',
          networkHttpMaxOpen: 2,
          networkLocalAddress: ['test networkLocalAddress'],
          networkMaxOpenFiles: 3,
          networkPortOpen: true,
          networkPortRandom: false,
          networkPortRange: 'test networkPortRange',
          piecesHashOnCompletion: true,
          piecesMemoryMax: 4,
          protocolPex: false,
          throttleGlobalDownSpeed: 5,
          throttleGlobalUpSpeed: 6,
          throttleMaxDownloads: 7,
          throttleMaxDownloadsGlobal: 8,
          throttleMaxPeersNormal: 9,
          throttleMaxPeersSeed: 10,
          throttleMaxUploads: 11,
          throttleMaxUploadsGlobal: 12,
          throttleMinPeersNormal: 13,
          throttleMinPeersSeed: 14,
          trackersNumWant: 15));

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
          create: (context) => mockClientSettingsProvider,
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
            child: SettingsScreen(
              index: 2,
            ),
          ));
        },
      ),
    );
  }

  group("Check different widgets in settings screen", () {
    testWidgets("Check if initial options displayed",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text('Settings'), findsOneWidget);
      expect(find.byIcon(Icons.wifi_rounded), findsOneWidget);
      expect(find.text('Bandwidth'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.connectdevelop), findsOneWidget);
      expect(find.text('Connectivity'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Resources'), findsOneWidget);
      expect(find.byIcon(Icons.speed_rounded), findsOneWidget);
      expect(find.text('Speed Limit'), findsOneWidget);
      expect(find.byIcon(Icons.security), findsOneWidget);
      expect(find.text('Authentication'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets("Check bandwidth options", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Bandwidth Expansion Card')), findsOneWidget);
      await tester.tap(find.byKey(Key('Bandwidth Expansion Card')));
      await tester.pumpAndSettle();
      expect(
          find.byKey(Key('Bandwidth option display column')), findsOneWidget);
      expect(find.text('Transfer Rate Throttles'), findsOneWidget);
      expect(find.text('Slot Availability'), findsOneWidget);
      //check if all the text boxes of bandwidth option displayed
      expect(find.byType(SettingsTextField), findsNWidgets(6));
      //check if values going to controllers correctly
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleGlobalDownSpeed
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleGlobalUpSpeed
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider.clientSettings.throttleMaxUploads
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMaxUploadsGlobal
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMaxDownloads
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMaxDownloadsGlobal
              .toString()),
          findsOneWidget);
    });

    testWidgets("Check Connectivity options", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byKey(Key('Bandwidth Expansion Card')));
      await tester.pumpAndSettle();
      expect(find.text('Slot Availability'), findsOneWidget);
      expect(find.byKey(Key('Connectivity Expansion Card')), findsOneWidget);
      await tester
          .ensureVisible(find.byKey(Key('Connectivity Expansion Card')));
      await tester.tap(find.byKey(Key('Connectivity Expansion Card')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Connectivity option display column')),
          findsOneWidget);
      expect(find.text('Incoming Connections'), findsOneWidget);
      expect(find.text('Decentralized Peer Discovery'), findsOneWidget);
      expect(find.text('Peers'), findsOneWidget);
      //check if all the text boxes of connectivity option displayed
      expect(find.byType(SettingsTextField), findsNWidgets(14));
      //check if all the check boxes of connectivity option displayed
      expect(find.byKey(Key('Checkbox Randomize Port')), findsOneWidget);
      expect(find.byKey(Key('Checkbox Open Port')), findsOneWidget);
      //check if checkbox contents displayed correctly
      expect(find.text('Randomize Port'), findsOneWidget);
      expect(find.text('Open Port'), findsOneWidget);
      expect(find.byKey(Key('Checkbox Enable DHT')), findsOneWidget);
      expect(find.byKey(Key('Checkbox Enable Peer Exchange')), findsOneWidget);
      expect(find.text('Enable DHT'), findsOneWidget);
      expect(find.text('Enable Peer Exchange'), findsOneWidget);
      //check if values going to text boxes controllers correctly
      expect(
          find.text(mockClientSettingsProvider.clientSettings.networkPortRange
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider.clientSettings.networkHttpMaxOpen
              .toString()),
          findsOneWidget);
      expect(
          find.text(
              mockClientSettingsProvider.clientSettings.dhtPort.toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMinPeersNormal
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMaxPeersNormal
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMinPeersSeed
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.throttleMaxPeersSeed
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider.clientSettings.trackersNumWant
              .toString()),
          findsOneWidget);
      //check if values going to check boxes controllers correctly
      final checkboxFinder1 = find.byKey(Key('Checkbox Randomize Port'));
      var checkbox1 = tester.firstWidget(checkboxFinder1) as CheckboxListTile;
      expect(checkbox1.value,
          mockClientSettingsProvider.clientSettings.networkPortRandom);
      final checkboxFinder2 = find.byKey(Key('Checkbox Open Port'));
      var checkbox2 = tester.firstWidget(checkboxFinder2) as CheckboxListTile;
      expect(checkbox2.value,
          mockClientSettingsProvider.clientSettings.networkPortOpen);
      final checkboxFinder3 = find.byKey(Key('Checkbox Enable DHT'));
      var checkbox3 = tester.firstWidget(checkboxFinder3) as CheckboxListTile;
      expect(checkbox3.value, mockClientSettingsProvider.clientSettings.dht);
      final checkboxFinder4 = find.byKey(Key('Checkbox Enable Peer Exchange'));
      var checkbox4 = tester.firstWidget(checkboxFinder4) as CheckboxListTile;
      expect(checkbox4.value,
          mockClientSettingsProvider.clientSettings.protocolPex);
    });

    testWidgets("Check resources options", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Resources Expansion Card')), findsOneWidget);
      await tester.ensureVisible(find.byKey(Key('Resources Expansion Card')));
      await tester.tap(find.byKey(Key('Resources Expansion Card')));
      await tester.pumpAndSettle();
      expect(
          find.byKey(Key('Resources options display column')), findsOneWidget);
      expect(find.text('Disk'), findsOneWidget);
      expect(find.text('Memory'), findsOneWidget);
      //check if all the text boxes of resources option displayed
      expect(find.byType(SettingsTextField), findsNWidgets(9));
      //check if values going to text boxes controllers correctly
      expect(
          find.text(mockClientSettingsProvider.clientSettings.directoryDefault
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider
              .clientSettings.networkMaxOpenFiles
              .toString()),
          findsOneWidget);
      expect(
          find.text(mockClientSettingsProvider.clientSettings.piecesMemoryMax
              .toString()),
          findsOneWidget);
      //check if checkbox and its contents displayed correctly
      expect(find.byKey(Key('Verify Hash checkbox')), findsOneWidget);
      expect(find.text('Verify Hash'), findsOneWidget);
      //check if values going to check boxes controllers correctly
      final checkboxFinder1 = find.byKey(Key('Verify Hash checkbox'));
      var checkbox1 = tester.firstWidget(checkboxFinder1) as CheckboxListTile;
      expect(checkbox1.value,
          mockClientSettingsProvider.clientSettings.piecesHashOnCompletion);
    });

    testWidgets("Check speed limit options", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Speed Limit Expansion Card')), findsOneWidget);
      await tester.ensureVisible(find.byKey(Key('Speed Limit Expansion Card')));
      await tester.tap(find.byKey(Key('Speed Limit Expansion Card')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Speed Limit options column')), findsOneWidget);
      expect(find.text('Download'), findsOneWidget);
      expect(find.text('Upload'), findsOneWidget);
      //check if all the dropdowns of speed limit option displayed
      expect(find.byKey(Key('Download Speed Dropdown')), findsOneWidget);
      expect(find.byKey(Key('Upload Speed Dropdown')), findsOneWidget);
      //check if values going to controllers correctly
      expect(find.text('Unlimited'), findsNWidgets(2));
      expect(find.text('1 kB/s'), findsNWidgets(2));
      await tester.tap(find.byKey(Key('Download Speed Dropdown')));
      await tester.pumpAndSettle();
      expect(find.text('1 kB/s'), findsNWidgets(3));
      await tester.ensureVisible(find.byKey(Key('Upload Speed Dropdown')));
      await tester.tap(find.byKey(Key('Upload Speed Dropdown')),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.text('1 kB/s'), findsNWidgets(2));
      await tester.ensureVisible(find.byKey(Key('Upload Speed Dropdown')));
      await tester.tap(find.byKey(Key('Upload Speed Dropdown')));
      await tester.pumpAndSettle();
      expect(find.text('1 kB/s'), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Set'), findsOneWidget);
    });

    testWidgets("Check authentication options", (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Authentication Expansion Card')), findsOneWidget);
      await tester
          .ensureVisible(find.byKey(Key('Authentication Expansion Card')));
      await tester.tap(find.byKey(Key('Authentication Expansion Card')));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Authentication option display column')),
          findsOneWidget);
      expect(find.text('Add User'), findsOneWidget);
      //check if all the text boxes of authentication option displayed
      expect(find.byType(SettingsTextField), findsNWidgets(9));
      //check if all the check boxes of authentication option displayed
      expect(find.byType(CheckboxListTile), findsNWidgets(3));
      //check if all the dropdown of authentication option displayed
      expect(find.byKey(Key('Authentication dropdown')), findsOneWidget);
      final dropdownFinder1 = find.byKey(Key('Authentication dropdown'));
      var dropdown1 = tester.firstWidget(dropdownFinder1) as DropdownButton;
      expect(dropdown1.value, 'rTorrent');
      expect(find.text('qBittorrent'), findsNWidgets(1));
      await tester.ensureVisible(find.byKey(Key('Authentication dropdown')));
      await tester.tap(find.byKey(Key('Authentication dropdown')));
      await tester.pumpAndSettle();
      expect(find.text('qBittorrent'), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });
  });
}
