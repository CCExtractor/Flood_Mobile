import 'package:flutter/material.dart';

import '../Constants/app_color.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    {String? text,
    BuildContext? context,
    ScaffoldMessengerState? scaffoldMessengerState,
    TextAlign? textAlign}) {
  assert(scaffoldMessengerState != null,
      'Either pass context or scaffoldMessengerState');
  var deviceSize = MediaQuery.of(context!).size;
  final _scaffoldMessengerState =
      scaffoldMessengerState ?? ScaffoldMessenger.of(context);
  final snackBar = SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    backgroundColor: AppColor.secondaryColor,
    elevation: 4,
    margin: EdgeInsets.symmetric(
        horizontal: deviceSize.width * .03, vertical: deviceSize.height * .02),
    padding: EdgeInsets.symmetric(
        horizontal: deviceSize.width * .035,
        vertical: deviceSize.height * .008),
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: 1200),
    action: SnackBarAction(
      label: 'close',
      onPressed: () {
        print('check');
        _scaffoldMessengerState.hideCurrentSnackBar();
      },
    ),
    content: Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColor.greenAccentColor,
      ),
    ),
  );

  return _scaffoldMessengerState.showSnackBar(snackBar);
}
