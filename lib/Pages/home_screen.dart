import 'package:flood_mobile/Api/api.dart';
import 'package:flood_mobile/Components/nav_drawer_list_tile.dart';
import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Pages/torrent_screen.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flood_mobile/Api/server_sent_events_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SSEApi.subscribeToSSE(context);
    // SSEClient.subscribeToSSE(Api.baseUrl + Api.eventsStream,
    //         'jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJpYXQiOjE2MTc2MzA1MzgsImV4cCI6MTYxODIzNTMzOH0.XUQC5Uup_rIuVpMohpGDUgGnmoNu0xRBbjy82-qz_4w')
    //     .listen((event) {
    //   print('Id: ' + event.id);
    //   print('Event: ' + event.event);
    //   print('Data: ' + event.data);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;

    return KeyboardDismissOnTap(
      child: SimpleHiddenDrawer(
        withShadow: true,
        slidePercent: wp * 0.15,
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
              screenCurrent = TorrentScreen();
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
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {},
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
    double wp = MediaQuery.of(context).size.width;
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
                  width: wp * 0.2,
                  height: wp * 0.2,
                  image: AssetImage(
                    'assets/images/icon.png',
                  ),
                ),
              ],
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
                icon: Icons.rss_feed,
                onTap: () {
                  controller.position = 1;
                  controller.toggle();
                },
                title: 'Feed'),
            NavDrawerListTile(
                icon: Icons.settings,
                onTap: () {
                  controller.position = 2;
                  controller.toggle();
                },
                title: 'Settings'),
            NavDrawerListTile(
                icon: Icons.speed,
                onTap: () {
                  controller.position = 2;
                  controller.toggle();
                },
                title: 'Speed Limits'),
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
                  controller.toggle();
                },
                title: 'About'),
          ],
        ),
      ),
    );
  }
}
