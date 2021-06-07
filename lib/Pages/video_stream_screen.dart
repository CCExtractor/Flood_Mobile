import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class VideoStreamScreen extends StatefulWidget {
  VideoStreamScreen({Key key}) : super(key: key);

  @override
  _VideoStreamScreenState createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
      ),
    );
  }
}
