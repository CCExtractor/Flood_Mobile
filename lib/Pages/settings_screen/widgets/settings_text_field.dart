import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String? value) validator;
  final bool isText;
  final TextEditingController controller;
  final int themeIndex;
  SettingsTextField({
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.controller,
    this.isText = true,
    required this.themeIndex,
  });

  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            color: ThemeBloc.theme(widget.themeIndex).unselectedWidgetColor,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color:
                ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
          ),
          keyboardType:
              (widget.isText) ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
            hintText: widget.hintText,
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ThemeBloc.theme(widget.themeIndex)
                    .textTheme
                    .bodyLarge
                    ?.color),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                width: 1.0,
              ),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
