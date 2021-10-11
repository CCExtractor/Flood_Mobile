import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:badges/badges.dart';
import 'package:duration/duration.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/logout_alert.dart';
import 'package:flood_mobile/Components/nav_drawer_list_tile.dart';
import 'package:flood_mobile/Components/notification_popup_dialogue_container.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Constants/notification_keys.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
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
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Boolean that tells whether all torrents are currently paused
  late bool isPaused;

  @override
  void initState() {
    super.initState();

    AwesomeNotifications().actionStream.listen((receivedNotification) async {
      final actionKey = receivedNotification.buttonKeyPressed;

      // Not a desired action
      if (actionKey != NotificationConstants.PAUSE_ACTION_KEY &&
          actionKey != NotificationConstants.RESUME_ACTION_KEY) {
        return;
      }

      // Grab hashes of all the torrents
      List<String> hashes = Provider.of<HomeProvider>(context, listen: false)
          .torrentList
          .map((torrent) => torrent.hash)
          .toList();

      // Hashes are being printed in background as expected
      debugPrint('Hashes: ' + hashes.toString());

      // Pause downloads
      if (actionKey == NotificationConstants.PAUSE_ACTION_KEY) {
        await TorrentApi.stopTorrent(hashes: hashes, context: context);
        isPaused = true;
      }

      // Resume downloads
      else {
        await TorrentApi.startTorrent(hashes: hashes, context: context);
        isPaused = false;
      }
    });
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
          Widget screenCurrent = Container();
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
          return Consumer<HomeProvider>(builder: (context, homeModel, child) {
            debugPrint('Consumer called');
            // Display the 'Resume All' action by default
            isPaused = true;

            List<String> torrentStrings = [];

            for (TorrentModel model in homeModel.torrentList) {
              // Skip finished torrents
              if (model.status.contains('complete')) {
                continue;
              }

              // Create torrent-specific string
              String torrentString;

              // Torrent not being downloaded
              if (!model.status.contains('downloading')) {
                torrentString = 'Paused - ' + model.name;

                // Display dot-dot-dot for lengthy torrent strings
                if (torrentString.length > 51) {
                  torrentString = torrentString.substring(0, 48) + '...';
                }

                // Add finished torrents to the end
                torrentStrings.add(torrentString);
              }

              // Torrent being downloaded
              else {
                torrentString = model.percentComplete.round().toString() +
                    '% - ' +
                    prettyDuration(
                      Duration(
                        seconds: model.eta.toInt(),
                      ),
                      abbreviated: true,
                    ) +
                    ' - ' +
                    model.name;

                // Change to the 'Pause All' action
                isPaused = false;

                // Display dot-dot-dot for lengthy torrent strings
                if (torrentString.length > 45) {
                  torrentString = torrentString.substring(0, 43) + '...';
                }

                // Add unfinished torrents to top
                torrentStrings.insert(0, torrentString);
              }
            }

            // Create notification for unfinished downloads
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: NotificationConstants.UNFINISHED_DOWNLOADS_ID,
                channelKey: NotificationConstants.DOWNLOADS_CHANNEL_KEY,
                title:
                    '<b>${homeModel.downSpeed} \u{2B07} ${homeModel.upSpeed} \u{2B06}</b>',

                // TODO: [BUG] Collapsed notification should have a separate body
                body: torrentStrings.join('<br>'),
                notificationLayout: NotificationLayout.BigText,
                summary: isPaused ? 'Paused' : 'Downloading',
                locked: true,
                autoCancel: false,

                // TODO: [TEST] Time elapsed should not be visible
                showWhen: false,
              ),
              actionButtons: [
                NotificationActionButton(
                  key: isPaused
                      ? NotificationConstants.RESUME_ACTION_KEY
                      : NotificationConstants.PAUSE_ACTION_KEY,
                  label: isPaused ? 'Resume All' : 'Pause All',
                  buttonType: ActionButtonType.KeepOnTop,
                  autoCancel: false,
                ),
              ],
            );

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
              ),
              body: screenCurrent,
            );
          });
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
  late SimpleHiddenDrawerController controller;

  @override
  void initState() {
    super.initState();
  }

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
                showDialog(
                  context: context,
                  builder: (context) => LogOutAlert(
                    logoutOnClick: () async {
                      controller.toggle();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('floodToken', '');
                      Provider.of<UserDetailProvider>(context, listen: false)
                          .setToken('');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.loginScreenRoute,
                          (Route<dynamic> route) => false);
                    },
                  ),
                );
              },
              title: 'Logout',
            ),
            NavDrawerListTile(
                icon: FontAwesomeIcons.github,
                onTap: () {
                  controller.toggle();
                  launch(
                    'https://github.com/CCExtractor/Flood_Mobile#usage--screenshots',
                  );
                },
                title: 'GitHub'),
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
