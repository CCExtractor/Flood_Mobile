import 'package:flutter/material.dart';

class SpeedTextIconWidget extends StatelessWidget {
  final int themeIndex;
  final IconData speedIcon;
  final String speedText;
  final Color speedColor;
  const SpeedTextIconWidget({
    Key? key,
    required this.themeIndex,
    required this.speedIcon,
    required this.speedText,
    required this.speedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        mainAxisAlignment: speedIcon == Icons.arrow_upward_rounded
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Icon(
            speedIcon,
            color: speedColor,
            size: 23,
          ),
          Text(
            speedText,
            style: TextStyle(
              color: speedColor,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
