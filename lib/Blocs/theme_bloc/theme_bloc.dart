import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static ThemeMode themeMode = ThemeMode.dark;

  ThemeBloc() : super(ThemeState(themeMode: themeMode)) {
    getPreviousTheme();
    on<ToggleThemeEvent>((event, emit) => _toggleTheme(event, emit));
  }

  // Retrieve the previously set theme from SharedPreferences
  Future<void> getPreviousTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedThemeMode = prefs.getString('themeMode');

      themeMode = _convertStringToThemeMode(storedThemeMode);
    } catch (error) {
      print('Error retrieving theme mode from SharedPreferences: $error');
    }
  }

  ThemeMode _convertStringToThemeMode(String? themeModeString) {
    switch (themeModeString) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.dark; // Default to a fallback theme mode
    }
  }

  // Check if the current theme mode is dark mode
  bool get isDarkMode => state.themeMode == ThemeMode.dark;

  // Return the appropriate theme based on the index
  static ThemeData theme(int index) =>
      index == 2 ? MyThemes.darkTheme : MyThemes.lightTheme;

  // Toggle between dark and light theme modes
  void _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeState(themeMode: themeMode));
    _saveThemeMode(themeMode);
  }

  // Save the theme mode to SharedPreferences
  void _saveThemeMode(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('themeMode', themeMode.toString());
    } catch (error) {
      print('Error saving theme mode to SharedPreferences: $error');
    }
  }
}
