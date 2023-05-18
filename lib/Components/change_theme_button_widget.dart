import 'package:flutter/material.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  final Function toggleTheme;

  const ChangeThemeButtonWidget({Key? key, required this.toggleTheme})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      onPressed: () {
        toggleTheme();
        themeProvider.toggleTheme();
      },
      icon: Icon(themeProvider.isDarkMode
          ? Icons.wb_sunny_rounded
          : Icons.mode_night_rounded),
    );
  }
}
