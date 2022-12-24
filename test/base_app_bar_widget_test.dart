import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Components/change_theme_button_widget.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(() {});
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
            child: BaseAppBar(
              appBar: AppBar(),
              index: 2,
            ),
          ));
        },
      ),
    );
  }

  group("Check different widgets in base_app_bar", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('App icon key')), findsOneWidget);
      expect(find.byType(ChangeThemeButtonWidget), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny_rounded), findsOneWidget);
      expect(find.byIcon(Icons.mode_night_rounded), findsNothing);
      final themeFinder1 = find.byKey(Key('AppBar Key'));
      var theme1 = tester.firstWidget(themeFinder1) as AppBar;
      expect(theme1.backgroundColor, Color(0xff0E2537));
      await tester.tap(find.byIcon(Icons.wb_sunny_rounded));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.mode_night_rounded), findsOneWidget);
      final themeFinder2 = find.byKey(Key('AppBar Key'));
      var theme2 = tester.firstWidget(themeFinder2) as AppBar;
      expect(theme2.backgroundColor, Colors.white);
    });
  });
}
