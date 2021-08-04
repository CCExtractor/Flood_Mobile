import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget popupDialogueContainer() {
  List<Widget> recentActions = [
    ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finished Downloading",
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
            "Jan 24, 2021, 1:18PM",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "LibreOffice_7.1.3_MacOS_x86-54.dmg",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finished Downloading",
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
            "Jan 24, 2021, 1:18PM",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "LibreOffice_7.1.3_MacOS",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finished Downloading",
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
            "Jan 24, 2021, 1:18PM",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "LibreOffice_7.1.3_MacOS",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finished Downloading",
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
            "Jan 24, 2021, 1:18PM",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "LibreOffice_7.1.3_MacOS",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  ];
  return Container(
    color: AppColor.secondaryColor,
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: recentActions.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 3) {
          return Column(
            children: [
              recentActions[index],
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
            recentActions[index],
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    ),
  );
}
