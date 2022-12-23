import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String? value) validator;
  final bool isText;
  final TextEditingController controller;
  final int index;

  SettingsTextField({
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.index,
    this.isText = true,
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
            color: ThemeProvider.theme((widget.index)).unselectedWidgetColor,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color: ThemeProvider.theme((widget.index)).textTheme.bodyText1?.color,
          ),
          keyboardType:
              (widget.isText) ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: ThemeProvider.theme((widget.index)).primaryColorLight,
            // labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ThemeProvider.theme((widget.index)).textTheme.bodyText1?.color),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ThemeProvider.theme((widget.index)).primaryColorLight,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: ThemeProvider.theme((widget.index)).primaryColorLight,
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
