import 'package:flutter/material.dart';

enum SnackbarType {
  information,
  caution,
  success,
}

SnackBar addFloodSnackBar(
  SnackbarType snackbarType,
  String title,
  String ctaText,
) {
  return SnackBar(
    backgroundColor: snackbarType == SnackbarType.success
        ? Colors.greenAccent
        : snackbarType == SnackbarType.information
            ? Colors.lightBlueAccent
            : Colors.orange,
    content: Row(
      children: [
        Icon(
          snackbarType == SnackbarType.success
              ? Icons.check_circle
              : snackbarType == SnackbarType.information
                  ? Icons.lightbulb_outline
                  : Icons.warning_outlined,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
    action: SnackBarAction(
      label: ctaText,
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}
