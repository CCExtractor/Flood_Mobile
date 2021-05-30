import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const BaseAppBar({Key key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image(
        image: AssetImage(
          'assets/images/icon.png',
        ),
        width: 60,
        height: 60,
      ),
      centerTitle: true,
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
