import 'dart:math';

import 'package:duration/duration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
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
                    bool isExpanded = false;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: wp * 0.02),
                      child: ExpansionTileCard(
                        onExpansionChanged: (value) {
                          setState(() {
                            isExpanded = value;
                          });
                        },
                        elevation: 0,
                        expandedColor: AppColor.primaryColor,
                        baseColor: AppColor.primaryColor,
                        title: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            snapshot.data[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    LinearPercentIndicator(
                                      padding: EdgeInsets.all(0),
                                      width: wp * 0.5,
                                      lineHeight: 5.0,
                                      percent: snapshot
                                              .data[index].percentComplete
                                              .roundToDouble() /
                                          100,
                                      backgroundColor: AppColor.blueAccentColor
                                          .withAlpha(80),
                                      progressColor: (snapshot
                                                  .data[index].percentComplete
                                                  .toStringAsFixed(1) ==
                                              '100.0')
                                          ? AppColor.greenAccentColor
                                          : Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(snapshot.data[index].percentComplete
                                            .toStringAsFixed(1) +
                                        " %"),
                                  ],
                                ),
                                SizedBox(
                                  height: hp * 0.01,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (snapshot.data[index].status
                                              .contains('active'))
                                          ? 'Downloading  '
                                          : 'Stopped  ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      (snapshot.data[index].eta.toInt() != -1)
                                          ? ('ETA: ') +
                                              prettyDuration(
                                                  Duration(
                                                    seconds: snapshot
                                                        .data[index].eta
                                                        .toInt(),
                                                  ),
                                                  abbreviated: true)
                                          : 'ETA : ∞',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hp * 0.002,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (snapshot.data[index].bytesDone /
                                                  pow(10, 9)) <=
                                              1
                                          ? (snapshot.data[index].bytesDone /
                                                      pow(10, 6))
                                                  .toStringAsFixed(2) +
                                              ' MB'
                                          : (snapshot.data[index].bytesDone /
                                                      pow(10, 9))
                                                  .toStringAsFixed(2) +
                                              ' GB',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(' / '),
                                    Text(
                                      (snapshot.data[index].sizeBytes /
                                                  pow(10, 9)) <=
                                              1
                                          ? (snapshot.data[index].sizeBytes /
                                                      pow(10, 6))
                                                  .toStringAsFixed(2) +
                                              ' MB'
                                          : (snapshot.data[index].sizeBytes /
                                                      pow(10, 9))
                                                  .toStringAsFixed(2) +
                                              ' GB',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (snapshot.data[index].status.contains('active'))
                                ? GestureDetector(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.stop,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    onTap: () {
                                      TorrentApi.stopTorrent(
                                          context: context,
                                          hashes: [snapshot.data[index].hash]);
                                    },
                                  )
                                : GestureDetector(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    onTap: () {
                                      TorrentApi.startTorrent(
                                          context: context,
                                          hashes: [snapshot.data[index].hash]);
                                    },
                                  ),
                            (!isExpanded)
                                ? Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                  ),
                          ],
                        ),
                        children: [
                          Card(
                            color: AppColor.secondaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                  ),
                                  Text(
                                    'General',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: hp * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date Added'),
                                      Text(DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index].dateAdded
                                                          .toInt() *
                                                      1000)
                                              .day
                                              .toString() +
                                          ' / ' +
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index].dateAdded
                                                          .toInt() *
                                                      1000)
                                              .month
                                              .toString() +
                                          ' / ' +
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index].dateAdded
                                                          .toInt() *
                                                      1000)
                                              .year
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date Created'),
                                      Text(DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index]
                                                          .dateCreated
                                                          .toInt() *
                                                      1000)
                                              .day
                                              .toString() +
                                          ' / ' +
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index]
                                                          .dateCreated
                                                          .toInt() *
                                                      1000)
                                              .month
                                              .toString() +
                                          ' / ' +
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  snapshot.data[index]
                                                          .dateCreated
                                                          .toInt() *
                                                      1000)
                                              .year
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Location'),
                                      Text(snapshot.data[index].directory),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tags',
                                      ),
                                      Text((snapshot.data[index].tags.length !=
                                              0)
                                          ? snapshot.data[index].tags.toString()
                                          : 'None'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.03,
                                  ),
                                  Text(
                                    'Transfer',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: hp * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Peers'),
                                      Text(snapshot.data[index].peersConnected
                                              .toInt()
                                              .toString() +
                                          ' connected of ' +
                                          snapshot.data[index].peersTotal
                                              .toInt()
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Seeds'),
                                      Text(snapshot.data[index].seedsConnected
                                              .toInt()
                                              .toString() +
                                          ' connected of ' +
                                          snapshot.data[index].seedsTotal
                                              .toInt()
                                              .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.03,
                                  ),
                                  Text(
                                    'Torrent',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: hp * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Size'),
                                      Text(snapshot.data[index].directory),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp * 0.005,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Type',
                                      ),
                                      Text(snapshot.data[index].isPrivate
                                          ? 'Private'
                                          : 'Public'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
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
