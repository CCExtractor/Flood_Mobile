import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';

class NotificationPopupDialogueContainer extends StatelessWidget {
  final int themeIndex;

  const NotificationPopupDialogueContainer({required this.themeIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        NotificationApi.getNotifications(context: context);
        final notifications = state.notificationModel.notifications;
        return (notifications.length == 0)
            ? Container(
                color: ThemeBloc.theme(themeIndex).primaryColor,
                width: 300,
                child: Text(
                  'No notifications to display',
                  style: TextStyle(
                    color:
                        ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
                  ),
                ),
              )
            : Container(
                color: ThemeBloc.theme(themeIndex).primaryColor,
                width: 300.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == notifications.length - 1) {
                      return Column(
                        children: [
                          NotificationListTile(
                            model: notifications[index],
                            themeIndex: themeIndex,
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          TextButton(
                            onPressed: () {
                              // setState(() {
                              NotificationApi.clearNotification(
                                  context: context);
                              // });
                            },
                            style: TextButton.styleFrom(
                              fixedSize: Size(200, 50),
                            ),
                            child: Text(
                              'Clear All',
                              style: TextStyle(
                                color: ThemeBloc.theme(themeIndex)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        NotificationListTile(
                          model: notifications[index],
                          themeIndex: themeIndex,
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              );
      },
    );
  }
}

class NotificationListTile extends StatelessWidget {
  final NotificationContentModel model;
  final int themeIndex;

  const NotificationListTile({
    required this.model,
    required this.themeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.status.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: ThemeBloc.theme(themeIndex).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            DateTime.fromMillisecondsSinceEpoch(model.ts).toString(),
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          SizedBox(height: 4),
          Text(
            model.name.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
