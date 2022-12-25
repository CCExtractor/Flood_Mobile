import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListTile extends StatelessWidget {
  final CurrentUserDetailModel userModel;
  final bool isCurrent;

  const UsersListTile({
    Key? key,
    required this.userModel,
    required this.isCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: ThemeProvider.theme.primaryColorLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ThemeProvider.theme.primaryColor,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              userModel.username,
              style: TextStyle(
                color: ThemeProvider.theme.textTheme.bodyText1?.color,
              ),
            ),
            Spacer(),
            (isCurrent)
                ? Container(
                    decoration: BoxDecoration(
                      color: ThemeProvider.theme.highlightColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 4.0,
                      ),
                      child: Text('Current User'),
                    ),
                  )
                : Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        AuthApi.deleteUser(context, userModel.username);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20.0,
                      ),
                    ),
                  ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
