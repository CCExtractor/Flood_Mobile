import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  final Function toggleTheme;

  const ChangeThemeButtonWidget({Key? key, required this.toggleTheme})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return IconButton(
      key: Key("Change Theme Button"),
      onPressed: () {
        toggleTheme();
        themeBloc.add(ToggleThemeEvent());
      },
      icon: Icon(themeBloc.isDarkMode
          ? Icons.wb_sunny_rounded
          : Icons.mode_night_rounded),
    );
  }
}
