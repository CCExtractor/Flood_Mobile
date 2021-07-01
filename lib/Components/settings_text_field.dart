import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  String labelText;
  String hintText;
  Function validator;

  SettingsTextField(
      {@required this.hintText,
      @required this.labelText,
      @required this.validator});

  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: AppColor.textColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.secondaryColor,
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.secondaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: widget.validator,
    );
  }
}
