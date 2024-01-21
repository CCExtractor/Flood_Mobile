import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class LoginScreenTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? trailingIconButton1;
  final Widget? trailingIconButton2;
  final int themeIndex;

  const LoginScreenTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.themeIndex,
    this.trailingIconButton1,
    this.trailingIconButton2,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeBloc.theme(themeIndex).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            cursorColor:
                ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return context.l10n.login_screen_textfield_validator;
              }
              return null;
            },
            style: TextStyle(
              color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                trailingIconButton1 ?? Container(),
                trailingIconButton2 ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
