import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';

class LogOutAlert extends StatelessWidget {
  const LogOutAlert({Key? key, @required this.logoutOnClick})
      : assert(logoutOnClick != null),
        super(key: key);
  final VoidCallback? logoutOnClick;

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    return AlertDialog(
      key: Key('Alert Dialog'),
      elevation: 0,
      backgroundColor: ThemeProvider.theme.primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      contentPadding: EdgeInsets.all(20),
      content: Text(
        'Are you sure you want to\n Log out ?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ThemeProvider.theme.textTheme.bodyText1?.color,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actionsPadding: EdgeInsets.all(5),
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
                ThemeProvider.theme.dialogBackgroundColor),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            'No',
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
            backgroundColor:
                MaterialStateProperty.all(ThemeProvider.theme.primaryColorDark),
          ),
          onPressed: logoutOnClick,
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
