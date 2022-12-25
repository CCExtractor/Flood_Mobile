import 'package:flood_mobile/Components/users_list_tile.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  final List<CurrentUserDetailModel> usersList;
  final String currentUsername;

  const UsersListView({
    Key? key,
    required this.usersList,
    required this.currentUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: usersList.length,
      itemBuilder: (context, index) {
        return UsersListTile(
          userModel: usersList[index],
          isCurrent: usersList[index].username == currentUsername,
        );
      },
    );
  }
}
