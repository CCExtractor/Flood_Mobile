import 'package:flutter/material.dart';

import '../Constants/theme_provider.dart';

class NavDrawerListTile extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final int index;
  NavDrawerListTile({
    required this.icon,
    required this.onTap,
    required this.title,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: ThemeProvider.theme(index).textTheme.bodyLarge?.color,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: ThemeProvider.theme(index).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
