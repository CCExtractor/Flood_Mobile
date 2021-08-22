import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String? value) validator;
  final bool isText;
  final TextEditingController controller;

  SettingsTextField({
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.controller,
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
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          style: TextStyle(
            color: AppColor.textColor,
          ),
          keyboardType:
              (!widget.isText) ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: AppColor.secondaryColor,
            // labelText: widget.labelText,
            hintText: widget.hintText,
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
