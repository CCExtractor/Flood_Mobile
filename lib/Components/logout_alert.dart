import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class LogOutAlert extends StatelessWidget {
  const LogOutAlert({Key? key, @required this.logoutOnClick})
      : assert(logoutOnClick != null),
        super(key: key);
  final VoidCallback? logoutOnClick;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
        backgroundColor: AppColor.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        contentPadding: EdgeInsets.all(20),
        content: Text(
          'Are you sure you want to\n Log out ?',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsPadding: EdgeInsets.only(bottom: 10),
        actions: [
          // Yes - ElevatedButton
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              )),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(deviceHeight * .160, deviceHeight * .059),
              ),
              backgroundColor:
                  MaterialStateProperty.all(AppColor.greenAccentColor),
            ),
            onPressed: logoutOnClick,
            child: Text('Yes'),
          ),

          // No - ElevatedButton
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                Size(deviceHeight * .160, deviceHeight * .059),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              )),
              backgroundColor:
                  MaterialStateProperty.all(AppColor.greyAccentColor),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text('No'),
          )
        ]);
  }
}