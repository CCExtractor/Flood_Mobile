import 'package:badges/badges.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Components/nav_drawer_list_tile.dart';
import 'package:flood_mobile/Components/notification_popup_dialogue_container.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Pages/about_screen.dart';
import 'package:flood_mobile/Pages/settings_screen.dart';
import 'package:flood_mobile/Pages/torrent_screen.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Provider/sse_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //Initialize the ap
    Provider.of<SSEProvider>(context, listen: false).listenToSSE(context);
    ClientApi.getClientSettings(context);
    NotificationApi.getNotifications(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double wp = MediaQuery.of(context).size.width;

    return KeyboardDismissOnTap(
      child: SimpleHiddenDrawer(
        withShadow: true,
        slidePercent: wp > 600 ? wp * 0.025 : wp * 0.13,
        contentCornerRadius: 40,
        menu: Menu(),
        screenSelectedBuilder: (position, controller) {
          Widget screenCurrent;
          switch (position) {
            case 0:
              screenCurrent = TorrentScreen();
              break;
            case 1:
              screenCurrent = TorrentScreen();
              break;
            case 2:
              screenCurrent = SettingsScreen();
              break;
            case 5:
              screenCurrent = AboutScreen();
              break;
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.toggle();
                },
              ),
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
                      Provider.of<HomeProvider>(context)
                          .unreadNotifications
                          .toString(),
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
            ),
            body: screenCurrent,
          );
        },
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  SimpleHiddenDrawerController controller;

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: AppColor.secondaryColor,
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(top: 30.0, left: 5),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  width: 80,
                  height: 80,
                  image: AssetImage(
                    'assets/images/icon.png',
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.network(
                    'https://img.shields.io/github/v/release/CCExtractor/Flood_Mobile?include_prereleases',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hp * 0.01,
            ),
            NavDrawerListTile(
                icon: Icons.dashboard,
                onTap: () {
                  controller.position = 0;
                  controller.toggle();
                },
                title: 'Torrents'),
            NavDrawerListTile(
                icon: Icons.settings,
                onTap: () {
                  controller.position = 2;
                  controller.toggle();
                },
                title: 'Settings'),
            NavDrawerListTile(
                icon: Icons.exit_to_app,
                onTap: () async {
                  controller.toggle();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('floodToken', '');
                  Provider.of<UserDetailProvider>(context, listen: false)
                      .setToken('');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreenRoute, (Route<dynamic> route) => false);
                },
                title: 'Logout'),
            NavDrawerListTile(
                icon: Icons.info,
                onTap: () {
                  controller.position = 5;
                  controller.toggle();
                },
                title: 'About'),
          ],
        ),
      ),
    );
  }
}
