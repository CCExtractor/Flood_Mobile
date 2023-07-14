import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:badges/badges.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/power_management_bloc/power_management_bloc.dart';
import 'package:flood_mobile/Blocs/sse_bloc/sse_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Notifications/notification_controller.dart';
import 'package:flood_mobile/Pages/about_screen/about_screen.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/add_torrent_file.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/dark_transition.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/menu_widget.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/notification_popup_dialogue_container.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/popup_menu_buttons.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/rss_feed_button_widget.dart';
import 'package:flood_mobile/Pages/settings_screen/settings_screen.dart';
import 'package:flood_mobile/Pages/torrent_screen/torrent_screen.dart';
import 'package:flood_mobile/Pages/widgets/toast_component.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class HomeScreen extends StatefulWidget {
  final int? themeIndex;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  HomeScreen({Key? key, required this.themeIndex}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _file;
  late String base64;
  late String directoryDefault;
  DateTime timeBackPressed = DateTime.now();
  bool isDark = false;
  final Battery _battery = Battery();
  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  Future<void> _updateBatteryState(BatteryState state) async {
    if (_batteryState == state) return;
    _batteryState = state;
    BlocProvider.of<PowerManagementBloc>(context, listen: false).add(
      SetDownloadChargingConnectedEvent(currentBatteryState: _batteryState),
    );

    bool isChargingConnected = BlocProvider.of<PowerManagementBloc>(context)
        .state
        .downloadChargingConnected;
    if (isChargingConnected && !(_batteryState == BatteryState.charging)) {
      BlocProvider.of<HomeScreenBloc>(context, listen: false)
          .state
          .torrentList
          .forEach((element) {
        if (element.status.contains('downloading')) {
          TorrentApi.stopTorrent(hashes: [element.hash], context: context);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );
    _processInitialUri();
    _listenForUri();
    AuthApi.getUsersList(context);
    BlocProvider.of<UserInterfaceBloc>(context, listen: false)
        .add(GetPreviousSetUserInterfaceEvent());
  }

  @override
  void dispose() {
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //Initialize the app
    BlocProvider.of<SSEBloc>(context, listen: false)
        .add(SetSSEListenEvent(context: context));
    ClientApi.getClientSettings(context);
    NotificationApi.getNotifications(context: context);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);
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
          backgroundColor:
              ThemeBloc.theme(widget.themeIndex ?? 2).colorScheme.background,
          builder: (context) {
            return AddAutoTorrent(
              base64: base64,
              imageBytes: imageBytes,
              uriString: uriString,
              themeIndex: 2,
            );
          },
        );
      }
    } on UnsupportedError catch (error) {
      print('Something went wrong. Please try again');
      print(error.message);
    } on IOException catch (error) {
      print('Something went wrong. Please try again');
      print(error);
    } on Exception catch (error) {
      print('Something went wrong. Please try again');
      print(error.toString());
    }
  }

  toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return DarkTransition(
        themeIndex: widget.themeIndex ?? 2,
        isDark: isDark,
        offset: Offset(mediaQuery.viewPadding.left + 115 + 23,
            mediaQuery.viewPadding.top + 35 + 25),
        duration: const Duration(milliseconds: 800),
        childBuilder: (context, int themeIndex, bool needsSetup, int position,
            Function(int) updatePosition) {
          return KeyboardDismissOnTap(
            child: SimpleHiddenDrawer(
              withShadow: true,
              slidePercent: 80,
              initPositionSelected: position,
              contentCornerRadius: 40,
              menu: Menu(
                  toggleTheme: toggleTheme,
                  themeIndex: themeIndex,
                  updatePosition: updatePosition),
              screenSelectedBuilder: (_, controller) {
                Widget screenCurrent = Container();
                switch (position) {
                  case 0:
                    screenCurrent = TorrentScreen(themeIndex: themeIndex);
                    break;
                  case 1:
                    screenCurrent = TorrentScreen(themeIndex: themeIndex);
                    break;
                  case 2:
                    screenCurrent = SettingsScreen(themeIndex: themeIndex);
                    break;
                  case 4:
                    screenCurrent = AboutScreen(themeIndex: themeIndex);
                    break;
                }
                if (needsSetup) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    controller.open();
                  });
                }

                return BlocBuilder<HomeScreenBloc, HomeScreenState>(
                  builder: (context, homeScreenState) {
                    return BlocBuilder<MultipleSelectTorrentBloc,
                        MultipleSelectTorrentState>(
                      builder: (context, state) {
                        final selectedTorrent =
                            BlocProvider.of<MultipleSelectTorrentBloc>(context,
                                listen: false);
                        return WillPopScope(
                          onWillPop: () =>
                              onBackPressed(timeBackPressed, context),
                          child: Scaffold(
                            appBar: AppBar(
                              key: Key('AppBar $themeIndex'),
                              leading: !selectedTorrent.state.isSelectionMode
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        key: Key('Menu Icon $themeIndex'),
                                        color: ThemeBloc.theme(themeIndex)
                                            .textTheme
                                            .bodyLarge
                                            ?.color,
                                      ),
                                      onPressed: () {
                                        controller.toggle();
                                      },
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedTorrent
                                              .add(ChangeSelectionModeEvent());
                                          selectedTorrent.add(
                                              RemoveAllItemsFromListEvent());
                                          selectedTorrent.add(
                                              RemoveAllIndexFromListEvent());
                                        });
                                      },
                                      icon: Icon(Icons.close)),
                              title: Image(
                                key: Key('Flood Icon $themeIndex'),
                                image: AssetImage(
                                  'assets/images/icon.png',
                                ),
                                width: 60,
                                height: 60,
                              ),
                              centerTitle: true,
                              backgroundColor:
                                  ThemeBloc.theme(themeIndex).primaryColor,
                              elevation: 0,
                              actions: [
                                if (!selectedTorrent.state.isSelectionMode)
                                  RSSFeedButtonWidget(themeIndex: themeIndex),
                                if (!selectedTorrent.state.isSelectionMode)
                                  Badge(
                                    showBadge:
                                        homeScreenState.unreadNotifications == 0
                                            ? false
                                            : true,
                                    key: Key('Badge Widget $themeIndex'),
                                    badgeColor: ThemeBloc.theme(themeIndex)
                                        .colorScheme
                                        .secondary,
                                    badgeContent: Center(
                                      child: Text(
                                        homeScreenState.unreadNotifications
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    position: BadgePosition(top: 0, end: 3),
                                    child: IconButton(
                                      key: Key(
                                          'Notification Button $themeIndex'),
                                      icon: Icon(
                                        Icons.notifications,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              key: Key(
                                                  'Notification Alert Dialog $themeIndex'),
                                              elevation: 0,
                                              backgroundColor:
                                                  ThemeBloc.theme(themeIndex)
                                                      .primaryColor,
                                              content:
                                                  NotificationPopupDialogueContainer(
                                                themeIndex: themeIndex,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                if (selectedTorrent.state.isSelectionMode)
                                  PopupMenuButtons(
                                    themeIndex: themeIndex,
                                  )
                              ],
                            ),
                            body: screenCurrent,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        });
  }
}

Future<bool> onBackPressed(
    DateTime timeBackPressed, BuildContext context) async {
  final differnce = DateTime.now().difference(timeBackPressed);
  final isExitWarning = differnce >= Duration(seconds: 2);
  timeBackPressed = DateTime.now();

  if (isExitWarning) {
    Toasts.showExitWarningToast(msg: context.l10n.home_screen_back_press_toast);
    return false;
  } else {
    Fluttertoast.cancel();
    return true;
  }
}
