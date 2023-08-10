import 'package:flutter/material.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class UsersListView extends StatelessWidget {
  final List<CurrentUserDetailModel> usersList;
  final String currentUsername;
  final int themeIndex;
  const UsersListView({
    Key? key,
    required this.usersList,
    required this.currentUsername,
    required this.themeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        return Container(
          key: Key('User list item container'),
          height: 50.0,
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: ThemeBloc.theme(themeIndex).primaryColorLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ThemeBloc.theme(themeIndex).primaryColor,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  usersList[index].username,
                  style: TextStyle(
                    color:
                        ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
                  ),
                ),
                Spacer(),
                (usersList[index].username == currentUsername)
                    ? Container(
                        decoration: BoxDecoration(
                          color: ThemeBloc.theme(themeIndex).highlightColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 3.0,
                          ),
                          child: Text(
                            context.l10n.auth_current_user,
                            style: TextStyle(
                                color: ThemeBloc.theme(1).primaryColor),
                          ),
                        ),
                      )
                    : Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            AuthApi.deleteUser(
                                context, usersList[index].username);
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
      },
    );
  }
}
