import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final int themeIndex;
  const BaseAppBar({
    Key? key,
    required this.appBar,
    required this.themeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: Key('AppBar Key'),
      title: Image(
        key: Key('App icon key'),
        image: AssetImage(
          'assets/images/icon.png',
        ),
        width: 60,
        height: 60,
      ),
      centerTitle: true,
      backgroundColor: ThemeBloc.theme(themeIndex).primaryColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
