import 'package:flood_mobile/Api/notifications_api.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget notificationPopupDialogueContainer({required BuildContext context}) {
  return (Provider.of<HomeProvider>(context)
              .notificationModel
              .notifications
              .length ==
          0)
      ? Container(
          color: ThemeProvider.theme.primaryColor,
          width: 300,
          child: Text(
            'No notifications to display',
            style: TextStyle(
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
            ),
          ),
        )
      : Container(
          color: ThemeProvider.theme.primaryColor,
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Provider.of<HomeProvider>(context)
                .notificationModel
                .notifications
                .length,
            itemBuilder: (BuildContext context, int index) {
              if (index ==
                  Provider.of<HomeProvider>(context)
                          .notificationModel
                          .notifications
                          .length -
                      1) {
                return Column(
                  children: [
                    NotificationListTile(
                        model: Provider.of<HomeProvider>(context, listen: false)
                            .notificationModel
                            .notifications[index]),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    TextButton(
                      onPressed: () {
                        NotificationApi.clearNotification(context: context);
                      },
                      style: TextButton.styleFrom(fixedSize: Size(200, 50)),
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    )
                  ],
                );
              }
              return Column(
                children: [
                  NotificationListTile(
                      model: Provider.of<HomeProvider>(context)
                          .notificationModel
                          .notifications[index]),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        );
}

class NotificationListTile extends StatelessWidget {
  NotificationContentModel model;

  NotificationListTile({required this.model});

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
                color: ThemeProvider.theme.accentColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            DateTime.fromMillisecondsSinceEpoch(model.ts).toString(),
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            model.name.toString(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
            ),
          ),
        ],
      ),
    );
  }
}
