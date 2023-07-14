import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class LoginScreenTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? trailingIconButton;
  final int themeIndex;

  const LoginScreenTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.themeIndex,
    this.trailingIconButton,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
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
                  color:
                      ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ThemeBloc.theme(themeIndex).primaryColorDark,
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
                ),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
                ),
              ),
            ),
          ),
          trailingIconButton ?? Container()
        ],
      ),
    );
  }
}
