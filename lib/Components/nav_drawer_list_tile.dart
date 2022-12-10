import 'package:flutter/material.dart';

import '../Constants/theme_provider.dart';

// ignore: must_be_immutable
class NavDrawerListTile extends StatelessWidget {
  VoidCallback onTap;
  IconData icon;
  String title;
  NavDrawerListTile({
    required this.icon,
    required this.onTap,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: ThemeProvider.theme.textTheme.bodyText1?.color,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: ThemeProvider.theme.textTheme.bodyText1?.color,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
