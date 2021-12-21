import 'package:flood_mobile/Constants/app_color.dart';
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
      backgroundColor: AppColor.secondaryColor,
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
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actionsPadding: EdgeInsets.all(5),
      actions: [
        // Yes - TextButton
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            backgroundColor:
                MaterialStateProperty.all(AppColor.greenAccentColor),
          ),
          onPressed: logoutOnClick,
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // No - TextButton
        TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              Size(hp * .160, hp * .059),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(AppColor.greyAccentColor),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            'No',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
