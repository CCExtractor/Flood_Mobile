import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class LogOutAlert extends StatelessWidget {
  final int themeIndex;
  const LogOutAlert(
      {Key? key, required this.logoutOnClick, required this.themeIndex})
      : assert(logoutOnClick != null),
        super(key: key);
  final VoidCallback? logoutOnClick;

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    return AlertDialog(
      key: Key('Logout AlertDialog'),
      elevation: 0,
      backgroundColor: ThemeBloc.theme(themeIndex).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      contentPadding: EdgeInsets.all(20),
      content: Text(
        context.l10n.logout_confirm,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actionsPadding: EdgeInsets.all(5),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        // No - TextButton
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
                ThemeBloc.theme(themeIndex).dialogBackgroundColor),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            context.l10n.button_no,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        // Yes - TextButton
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            backgroundColor: MaterialStateProperty.all(
                ThemeBloc.theme(themeIndex).primaryColorDark),
          ),
          onPressed: logoutOnClick,
          child: Text(
            context.l10n.button_yes,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
