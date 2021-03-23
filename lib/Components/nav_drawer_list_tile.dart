import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavDrawerListTile extends StatelessWidget {
  Function onTap;
  IconData icon;
  String title;
  NavDrawerListTile(
      {@required this.icon, @required this.onTap, @required this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }
}
