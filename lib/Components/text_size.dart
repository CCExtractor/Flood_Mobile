import 'package:flutter/material.dart';

class SText extends StatelessWidget {
  String text;

  SText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
    );
  }
}

class MText extends StatelessWidget {
  String text;

  MText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LText extends StatelessWidget {
  String text;

  LText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
