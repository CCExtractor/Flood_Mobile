import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';

class TorrentContentScreen extends StatefulWidget {
  TorrentContentScreen({Key key}) : super(key: key);

  @override
  _TorrentContentScreenState createState() => _TorrentContentScreenState();
}

class _TorrentContentScreenState extends State<TorrentContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.primaryColor,
      ),
    );
  }
}
