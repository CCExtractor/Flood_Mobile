import 'package:badges/badges.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notification_popup_dialogue_container.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const BaseAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeModel, child) {
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
          Badge(
            badgeColor: AppColor.blueAccentColor,
            badgeContent: Center(
              child: Text(
                homeModel.unreadNotifications.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            position: BadgePosition(top: 0, end: 3),
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColor.secondaryColor,
                        content: notificationPopupDialogueContainer(
                            context: context),
                      );
                    });
              },
            ),
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
