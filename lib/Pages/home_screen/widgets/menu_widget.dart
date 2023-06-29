import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/change_theme_button_widget.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/logout_alert.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/nav_drawer_list_tile.dart';

class Menu extends StatefulWidget {
  final Function toggleTheme;
  final int themeIndex;
  final Function(int) updatePosition;
  const Menu(
      {Key? key,
      required this.toggleTheme,
      required this.themeIndex,
      required this.updatePosition})
      : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late SimpleHiddenDrawerController controller;

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
        color: ThemeBloc.theme(widget.themeIndex).scaffoldBackgroundColor,
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
                  key: Key('Flood Icon menu ${widget.themeIndex}'),
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
                    key: Key('Release Shield ${widget.themeIndex}'),
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
              themeIndex: widget.themeIndex,
            ),
            NavDrawerListTile(
              icon: Icons.settings,
              onTap: () {
                controller.position = 2;
                widget.updatePosition(2);
                controller.toggle();
              },
              title: 'Settings',
              themeIndex: widget.themeIndex,
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
                      prefs.setString('floodUsername', '');
                      BlocProvider.of<UserDetailBloc>(context, listen: false)
                          .add(SetUserDetailsEvent(token: '', username: ''));
                      BlocProvider.of<UserDetailBloc>(context, listen: false)
                          .add(SetUsersListEvent(
                              usersList: <CurrentUserDetailModel>[]));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.loginScreenRoute,
                        (Route<dynamic> route) => false,
                        arguments: widget.themeIndex,
                      );
                    },
                    themeIndex: widget.themeIndex,
                  ),
                );
              },
              title: 'Logout',
              themeIndex: widget.themeIndex,
            ),
            NavDrawerListTile(
              icon: FontAwesomeIcons.github,
              onTap: () {
                controller.toggle();
                launchUrl(Uri.parse(
                  'https://github.com/CCExtractor/Flood_Mobile#usage--screenshots',
                ));
              },
              title: 'GitHub',
              themeIndex: widget.themeIndex,
            ),
            NavDrawerListTile(
              icon: Icons.info,
              onTap: () {
                controller.position = 4;
                widget.updatePosition(4);
                controller.toggle();
              },
              title: 'About',
              themeIndex: widget.themeIndex,
            ),
          ],
        ),
      ),
    );
  }
}
