import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/cupertino.dart';

class NotAdminLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeProvider.theme.errorColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ThemeProvider.theme.primaryColor,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("User is not Admin"),
      ),
    );
  }
}
