import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('ThemeBloc', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    tearDown(() {
      themeBloc.close();
    });

    test('Initial state is ThemeState with correct themeMode', () {
      expect(themeBloc.state, ThemeState(themeMode: ThemeMode.dark));
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits ThemeState(themeMode) after ToggleThemeEvent',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ToggleThemeEvent()),
      expect: () => [
        ThemeState(themeMode: ThemeMode.light),
      ],
    );

    test('isDarkMode getter returns correct value', () {
      expect(themeBloc.isDarkMode, false);
    });

    test('theme method returns correct ThemeData', () {
      expect(ThemeBloc.theme(1), MyThemes.lightTheme);
      expect(ThemeBloc.theme(2), MyThemes.darkTheme);
    });

    test('getPreviousTheme sets themeMode correctly', () async {
      // Assume themeMode was previously stored as ThemeMode.light
      SharedPreferences.setMockInitialValues({'themeMode': 'ThemeMode.light'});
      await themeBloc.getPreviousTheme();
      expect(themeBloc.state.themeMode, ThemeMode.light);
    });

    blocTest<ThemeBloc, ThemeState>(
      'updates themeMode after ToggleThemeEvent',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ToggleThemeEvent()),
      verify: (_) {
        expect(themeBloc.state.themeMode, ThemeMode.dark);
      },
    );
  });
}
