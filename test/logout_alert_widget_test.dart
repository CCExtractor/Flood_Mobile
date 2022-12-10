import 'package:flood_mobile/Components/logout_alert.dart';
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
            child: LogOutAlert(
              logoutOnClick: () {},
            ),
          ));
        },
      ),
    );
  }

  group("Check different widgets in logout_alert box", () {
    testWidgets("Check if widgets displayed correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byKey(Key('Logout AlertDialog')), findsOneWidget);
      expect(find.text('Are you sure you want to\n Log out ?'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'No'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Yes'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, 'No'));
      await tester.pumpAndSettle();
      expect(find.byKey(Key('Logout AlertDialog')), findsNothing);
    });
  });
}
