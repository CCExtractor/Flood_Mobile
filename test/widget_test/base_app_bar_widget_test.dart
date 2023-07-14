import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/bloc_provider_list.dart';
import 'package:flood_mobile/Pages/widgets/base_app_bar.dart';
import 'package:flood_mobile/l10n/l10n.dart';

void main() {
  setUp(() {});
  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: BlocProviders.multiBlocProviders,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: BaseAppBar(appBar: AppBar(), themeIndex: 2),
        ),
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
