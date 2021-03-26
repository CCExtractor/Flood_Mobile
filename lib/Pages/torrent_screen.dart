import 'dart:math';

import 'package:duration/duration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColor.primaryColor,
      child: StreamBuilder(
        stream: TorrentApi.getAllTorrents(context: context),
        builder:
            (BuildContext context, AsyncSnapshot<List<TorrentModel>> snapshot) {
          return (snapshot.hasData && snapshot.data.length != 0)
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return TorrentTile(model: snapshot.data[index]);
                  },
                )
              : Center(
                  child: SvgPicture.asset(
                    'assets/images/empty_dark.svg',
                    width: 120,
                    height: 120,
                  ),
                );
        },
      ),
    );
  }
}
