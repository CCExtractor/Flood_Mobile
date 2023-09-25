import 'package:flutter/material.dart';

enum SnackbarType {
  information,
  caution,
  success,
}

SnackBar addFloodSnackBar(
  SnackbarType snackbarType,
  String title,
  String ctaText, {
  String? undoText,
  VoidCallback? undoFunction,
}) {
  return SnackBar(
    backgroundColor: snackbarType == SnackbarType.success
        ? Colors.greenAccent
        : snackbarType == SnackbarType.information
            ? Colors.lightBlueAccent
            : Colors.orange,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          width: undoText == null ? 8 : 12,
        ),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Visibility(
          visible: undoText != null,
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: undoFunction,
                child: Text(
                  undoText ?? "Undo",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
    action: SnackBarAction(
      label: ctaText,
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}
