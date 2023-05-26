import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  final List<CurrentUserDetailModel> usersList;
  final String currentUsername;
  final int index;
  const UsersListView({
    Key? key,
    required this.usersList,
    required this.currentUsername,
    required this.index,
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
            color: ThemeProvider.theme(index).primaryColorLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ThemeProvider.theme(index).primaryColor,
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
                        ThemeProvider.theme(index).textTheme.bodyLarge?.color,
                  ),
                ),
                Spacer(),
                (usersList[index].username == currentUsername)
                    ? Container(
                        decoration: BoxDecoration(
                          color: ThemeProvider.theme(index).highlightColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            'Current User',
                            style: TextStyle(
                                color: ThemeProvider.theme(index).primaryColor),
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
