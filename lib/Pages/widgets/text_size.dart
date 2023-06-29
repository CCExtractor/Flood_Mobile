import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class SText extends StatelessWidget {
  final String text;
  final int themeIndex;
  SText({required this.text, required this.themeIndex});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18,
          color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500),
    );
  }
}

class MText extends StatelessWidget {
  final String text;

  MText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class LText extends StatelessWidget {
  final String text;

  LText({required this.text});

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
