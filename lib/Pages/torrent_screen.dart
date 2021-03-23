import 'package:duration/duration.dart';
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
                    return ListTile(
                      title: Text(
                        snapshot.data[index].name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                LinearPercentIndicator(
                                  width: wp * 0.6,
                                  lineHeight: 5.0,
                                  percent: snapshot.data[index].percentComplete
                                          .roundToDouble() /
                                      100,
                                  backgroundColor:
                                      AppColor.blueAccentColor.withAlpha(80),
                                  progressColor: (snapshot
                                              .data[index].percentComplete
                                              .toStringAsFixed(1) ==
                                          '100.0')
                                      ? AppColor.greenAccentColor
                                      : Colors.blue,
                                ),
                                Text(snapshot.data[index].percentComplete
                                        .toStringAsFixed(1) +
                                    " %"),
                              ],
                            ),
                            SizedBox(
                              height: hp * 0.01,
                            ),
                            Text(
                              (snapshot.data[index].eta.toInt() != -1)
                                  ? ('ETA: ') +
                                      prettyDuration(
                                          Duration(
                                            seconds: snapshot.data[index].eta
                                                .toInt(),
                                          ),
                                          abbreviated: true)
                                  : 'ETA : ∞',
                            )
                          ],
                        ),
                      ),
                      trailing: (snapshot.data[index].status.contains('active'))
                          ? IconButton(
                              icon: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              onPressed: () {
                                TorrentApi.stopTorrent(
                                    context: context,
                                    hashes: [snapshot.data[index].hash]);
                              },
                            )
                          : IconButton(
                              icon: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.stop,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              onPressed: () {
                                TorrentApi.startTorrent(
                                    context: context,
                                    hashes: [snapshot.data[index].hash]);
                              },
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
