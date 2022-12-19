import 'package:animated_theme_switcher/animated_theme_switcher.dart'
    as ThemePackage;
import 'package:flutter/material.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ThemePackage.ThemeSwitcher.withTheme(builder: (context, switcher, theme) {
      return IconButton(
        onPressed: () {
          switcher.changeTheme(
            theme: theme == MyThemes.darkTheme
                ? MyThemes.lightTheme
                : MyThemes.darkTheme,
            isReversed: false,
          );
          themeProvider.toggleTheme();
        },
        icon: Icon(themeProvider.isDarkMode
            ? Icons.wb_sunny_rounded
            : Icons.mode_night_rounded),
      );
    });
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
