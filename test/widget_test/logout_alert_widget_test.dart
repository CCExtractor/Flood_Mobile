import 'package:flood_mobile/Blocs/bloc_provider_list.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/logout_alert.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: BlocProviders.multiBlocProviders,
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: LogOutAlert(
            logoutOnClick: () {},
            themeIndex: 2,
          ),
        ),
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
