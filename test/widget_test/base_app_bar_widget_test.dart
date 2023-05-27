import 'package:flood_mobile/Components/base_app_bar.dart';
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
            child: BaseAppBar(appBar: AppBar(), index: 2),
          ));
        },
      ),
    );
  }

  group("Check different widgets in base_app_bar", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      // Verify that the AppBar and its child widgets are rendered correctly
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      // Verify that the Image widget has the correct key and properties
      final imageFinder = find.byKey(Key('App icon key'));
      expect(imageFinder, findsOneWidget);
      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.image, AssetImage('assets/images/icon.png'));
      expect(imageWidget.width, 60);
      expect(imageWidget.height, 60);

      // Verify that the AppBar has the correct key and properties
      final appBarFinder = find.byKey(Key('AppBar Key'));
      expect(appBarFinder, findsOneWidget);
      final appBarWidget = tester.widget<AppBar>(appBarFinder);
      expect(appBarWidget.centerTitle, true);
      expect(appBarWidget.backgroundColor, Color(0xff0e2537));
      expect(appBarWidget.elevation, 0);
    });
  });
}
