import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class NavDrawerListTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final int themeIndex;
  NavDrawerListTile({
    required this.icon,
    required this.onTap,
    required this.title,
    required this.themeIndex,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
