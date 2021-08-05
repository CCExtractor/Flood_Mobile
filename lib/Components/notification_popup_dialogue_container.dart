import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flood_mobile/Services/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget notificationPopupDialogueContainer({@required BuildContext context}) {
  return Container(
    color: AppColor.secondaryColor,
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
                  model: Provider.of<HomeProvider>(context)
                      .notificationModel
                      .notifications[index]),
              SizedBox(
                height: 10,
              ),
              Divider(),
              TextButton(
                onPressed: () {},
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

  NotificationListTile({@required this.model});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.status,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16,
                color: AppColor.blueAccentColor,
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
            model.name,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
