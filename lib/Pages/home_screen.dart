import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Components/add_automatic_torrent.dart';
import 'package:flood_mobile/Components/dark_transition.dart';
import 'package:flood_mobile/Components/logout_alert.dart';
import 'package:flood_mobile/Components/nav_drawer_list_tile.dart';
import 'package:flood_mobile/Components/notification_popup_dialogue_container.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
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
import 'package:uni_links/uni_links.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flood_mobile/Components/change_theme_button_widget.dart';
import '../Api/torrent_api.dart';
import '../Constants/notification_keys.dart';
import '../Provider/api_provider.dart';
import '../Components/RSSFeedButtonWidget.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _file;
  late String base64;
  late String directoryDefault;

  bool isDark = true;

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );
    _processInitialUri();
    _listenForUri();
  }

  @override
  void didChangeDependencies() {
    //Initialize the ap
    Provider.of<SSEProvider>(context, listen: false).listenToSSE(context);
    ClientApi.getClientSettings(context);
    NotificationApi.getNotifications(context: context);
    super.didChangeDependencies();
  }

  Future<void> _processInitialUri() async {
    String? uriString = await getInitialLink();
    _processUriandAddTorrent(uriString);
  }

  void _listenForUri() {
    linkStream.listen((uriString) => _processUriandAddTorrent(uriString));
  }

  Future<void> _processUriandAddTorrent(String? uriString) async {
    try {
      if (uriString != null) {
        _file = await toFile(uriString);
        List<int> imageBytes = _file!.readAsBytesSync();
        setState(() {
          base64 = base64Encode(imageBytes);
        });
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          isScrollControlled: true,
          context: context,
          backgroundColor: ThemeProvider.theme(2).backgroundColor,
          builder: (context) {
            return AddAutoTorrent(
              base64: base64,
              imageBytes: imageBytes,
              uriString: uriString,
              index: 2,
            );
          },
        );
      }
    } on UnsupportedError catch (e) {
      print('Something went wrong. Please try again');
      print(e.message);
    } on IOException catch (e) {
      print('Something went wrong. Please try again');
      print(e);
    } on Exception catch (e) {
      print('Something went wrong. Please try again');
      print(e.toString());
    }
  }

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    double wp = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context);

    return DarkTransition(
        isDark: isDark,
        offset: Offset(mediaQuery.viewPadding.left + 115 + 20,
            mediaQuery.viewPadding.top + 30 + 20),
        duration: const Duration(seconds: 1),
        childBuilder: (context, int index, bool needsSetup, int position,
            Function(int) updatePosition) {
          return KeyboardDismissOnTap(
            child: SimpleHiddenDrawer(
              withShadow: true,
              initPositionSelected: position,
              slidePercent: 80,
              contentCornerRadius: 40,
              menu: Menu(
                  toggleTheme: toggleTheme,
                  index: index,
                  updatePosition: updatePosition),
              screenSelectedBuilder: (position, controller) {
                Widget screenCurrent = Container();
                switch (position) {
                  case 0:
                    screenCurrent = TorrentScreen(
                      index: index,
                    );
                    break;
                  case 1:
                    screenCurrent = TorrentScreen(
                      index: index,
                    );
                    break;
                  case 2:
                    screenCurrent = SettingsScreen(
                      index: index,
                    );
                    break;
                  case 5:
                    screenCurrent = AboutScreen(
                      index: index,
                    );
                    break;
                }
                if (needsSetup) {
                  if (index == 1) {
                    controller.open();
                  }
                }
                return Consumer<HomeProvider>(
                    builder: (context, homeModel, child) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: ThemeProvider.theme(index)
                              .textTheme
                              .bodyText1
                              ?.color,
                        ),
                        onPressed: () {
                          controller.toggle();
                        },
                      ),
                      title: Image(
                        key: Key('Flood Icon'),
                        image: AssetImage(
                          'assets/images/icon.png',
                        ),
                        width: 60,
                        height: 60,
                      ),
                      centerTitle: true,
                      backgroundColor: ThemeProvider.theme(index).primaryColor,
                      elevation: 0,
                      actions: [
                        RSSFeedButtonWidget(
                          index: index,
                        ),
                        Badge(
                          key: Key('Badge Widget'),
                          badgeColor: ThemeProvider.theme(index).accentColor,
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
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    key: Key('Notification Alert Dialog'),
                                    elevation: 0,
                                    backgroundColor:
                                        ThemeProvider.theme(index).primaryColor,
                                    content: notificationPopupDialogueContainer(
                                      context: context,
                                      index: index,
                                    ),
                                  );
                                },
                              );
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
        });
  }
}

class NotificationController {
  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    late bool isPaused;
    HomeProvider homeModel = Provider.of<HomeProvider>(
        NavigationService.navigatorKey.currentContext!,
        listen: false);
    isPaused = true;
    final actionKey = receivedAction.buttonKeyPressed;

    // Not a desired action
    if (actionKey != NotificationConstants.PAUSE_ACTION_KEY &&
        actionKey != NotificationConstants.RESUME_ACTION_KEY) {
      return;
    }

    // Pause downloads
    if (actionKey == NotificationConstants.PAUSE_ACTION_KEY) {
      await TorrentApi.stopTorrent(
          hashes: [homeModel.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
      isPaused = true;
    }

    // Resume downloads
    else {
      await TorrentApi.startTorrent(
          hashes: [homeModel.torrentList[receivedAction.id!].hash],
          context: NavigationService.navigatorKey.currentContext!);
      isPaused = false;
    }
  }
}

class Menu extends StatefulWidget {
  final Function toggleTheme;
  final int index;
  final Function(int) updatePosition;
  const Menu(
      {Key? key,
      required this.toggleTheme,
      required this.index,
      required this.updatePosition})
      : super(key: key);
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
        color: ThemeProvider.theme(widget.index).scaffoldBackgroundColor,
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
                  key: Key('Flood Icon menu'),
                  width: 80,
                  height: 80,
                  image: AssetImage(
                    'assets/images/icon.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: ChangeThemeButtonWidget(
                    toggleTheme: widget.toggleTheme,
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
                    key: Key('Release Shield'),
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
                widget.updatePosition(0);
                controller.toggle();
              },
              title: 'Torrents',
              index: widget.index,
            ),
            NavDrawerListTile(
              icon: Icons.settings,
              onTap: () {
                controller.position = 2;
                widget.updatePosition(2);
                controller.toggle();
              },
              title: 'Settings',
              index: widget.index,
            ),
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
                    index: widget.index,
                  ),
                );
              },
              title: 'Logout',
              index: widget.index,
            ),
            NavDrawerListTile(
              icon: FontAwesomeIcons.github,
              onTap: () {
                controller.toggle();
                launch(
                  'https://github.com/CCExtractor/Flood_Mobile#usage--screenshots',
                );
              },
              title: 'GitHub',
              index: widget.index,
            ),
            NavDrawerListTile(
              icon: Icons.info,
              onTap: () {
                controller.position = 5;
                widget.updatePosition(5);
                controller.toggle();
              },
              title: 'About',
              index: widget.index,
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
