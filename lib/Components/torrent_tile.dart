import 'package:duration/duration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TorrentTile extends StatefulWidget {
  TorrentModel model;
  TorrentTile({@required this.model});

  @override
  _TorrentTileState createState() => _TorrentTileState();
}

class _TorrentTileState extends State<TorrentTile> {
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
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
            widget.model.name,
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
                      percent:
                          widget.model.percentComplete.roundToDouble() / 100,
                      backgroundColor: AppColor.blueAccentColor.withAlpha(80),
                      progressColor:
                          (widget.model.percentComplete.toStringAsFixed(1) ==
                                  '100.0')
                              ? AppColor.greenAccentColor
                              : Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        widget.model.percentComplete.toStringAsFixed(1) + " %"),
                  ],
                ),
                SizedBox(
                  height: hp * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      (widget.model.status.contains('downloading'))
                          ? 'Downloading  '
                          : 'Stopped  ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      (widget.model.eta.toInt() != -1)
                          ? ('ETA: ') +
                              prettyDuration(
                                  Duration(
                                    seconds: widget.model.eta.toInt(),
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
                      filesize(widget.model.bytesDone.toInt()),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(' / '),
                    Text(
                      filesize(widget.model.sizeBytes.toInt()),
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
            (widget.model.status.contains('downloading'))
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
                          context: context, hashes: [widget.model.hash]);
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
                          context: context, hashes: [widget.model.hash]);
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: hp * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date Added'),
                      Text(dateConverter(
                          timestamp: widget.model.dateAdded.toInt())),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date Created'),
                      Text(dateConverter(
                          timestamp: widget.model.dateCreated.toInt())),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location'),
                      Text(widget.model.directory),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tags',
                      ),
                      Text((widget.model.tags.length != 0)
                          ? widget.model.tags.toString()
                          : 'None'),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.03,
                  ),
                  Text(
                    'Transfer',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: hp * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Peers'),
                      Text(widget.model.peersConnected.toInt().toString() +
                          ' connected of ' +
                          widget.model.peersTotal.toInt().toString()),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Seeds'),
                      Text(widget.model.seedsConnected.toInt().toString() +
                          ' connected of ' +
                          widget.model.seedsTotal.toInt().toString()),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.03,
                  ),
                  Text(
                    'Torrent',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: hp * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Size'),
                      Text(widget.model.directory),
                    ],
                  ),
                  SizedBox(
                    height: hp * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Type',
                      ),
                      Text(widget.model.isPrivate ? 'Private' : 'Public'),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
