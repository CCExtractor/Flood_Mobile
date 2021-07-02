import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  String labelText;
  String hintText;
  Function validator;
  String defaultValue;
  bool isText;

  SettingsTextField(
      {@required this.hintText,
      @required this.labelText,
      @required this.validator,
      this.isText = true,
      this.defaultValue = ''});

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
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          style: TextStyle(
            color: AppColor.textColor,
          ),
          initialValue: widget.defaultValue,
          keyboardType:
              (!widget.isText) ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: AppColor.secondaryColor,
            // labelText: widget.labelText,
            // hintText: widget.hintText,
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColor.secondaryColor, width: 0.0),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColor.secondaryColor, width: 1.0),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
