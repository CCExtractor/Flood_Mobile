import 'package:flutter/material.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      icon: Icon(themeProvider.isDarkMode
          ? Icons.wb_sunny_rounded
          : Icons.mode_night_rounded),
    );
    //   Switch.adaptive(
    //   splashRadius: 2.0,
    //   activeThumbImage: AssetImage(
    //     'assets/images/moon.png',
    //   ),
    //   inactiveThumbImage: AssetImage('assets/images/sun.png'),
    //   value: themeProvider.isDarkMode,
    //   onChanged: (value) {
    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
    //     provider.toggleTheme(value);
    //   },
    // );
  }
}
