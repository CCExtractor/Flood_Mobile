import 'package:duration/duration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/delete_torrent_sheet.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TorrentTile extends StatefulWidget {
  final TorrentModel model;

  TorrentTile({required this.model});

  @override
  _TorrentTileState createState() => _TorrentTileState();
}

class _TorrentTileState extends State<TorrentTile> {
  bool isExpanded = false;

  void deleteTorrent() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      backgroundColor: ThemeProvider.theme.backgroundColor,
      builder: (context) {
        return DeleteTorrentSheet(
          torrent: widget.model,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FocusedMenuHolder(
          key: Key('Long Press Torrent Tile Menu'),
          menuBoxDecoration: BoxDecoration(
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
              borderRadius: BorderRadius.circular(50)),
          menuWidth: MediaQuery.of(context).size.width * 0.5,
          menuItemExtent: 60,
          onPressed: () {},
          menuItems: [
            FocusedMenuItem(
              title: Text(
                'Set Tags',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailingIcon: Icon(
                FontAwesomeIcons.tags,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () {},
            ),
            FocusedMenuItem(
              title: Text(
                'Check Hash',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailingIcon: Icon(
                Icons.tag,
                color: Colors.black,
              ),
              onPressed: () {
                TorrentApi.checkTorrentHash(
                    hashes: [widget.model.hash], context: context);
              },
            ),
            FocusedMenuItem(
              backgroundColor: Colors.redAccent,
              title: Text(
                'Delete',
              ),
              trailingIcon: Icon(
                Icons.delete,
                color: ThemeProvider.theme.textTheme.bodyText1?.color,
              ),
              onPressed: () {
                deleteTorrent();
              },
            ),
          ],
          child: ExpansionTileCard(
            key: Key(widget.model.hash),
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            elevation: 0,
            expandedColor: ThemeProvider.theme.primaryColor,
            baseColor: ThemeProvider.theme.primaryColor,
            title: ListTile(
              key: Key(widget.model.hash),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                widget.model.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ThemeProvider.theme.textTheme.bodyText1?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LinearPercentIndicator(
                            key: Key('Linear Progress Indicator'),
                            padding: EdgeInsets.all(0),
                            lineHeight: 5.0,
                            percent:
                                widget.model.percentComplete.roundToDouble() /
                                    100,
                            backgroundColor:
                                ThemeProvider.theme.accentColor.withAlpha(80),
                            progressColor: (widget.model.percentComplete
                                        .toStringAsFixed(1) ==
                                    '100.0')
                                ? ThemeProvider.theme.primaryColorDark
                                : Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(widget.model.percentComplete.toStringAsFixed(1) +
                            " %"),
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
                          key: Key('status widget'),
                          style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
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
                          key: Key('eta widget'),
                          style: TextStyle(
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1?.color),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hp * 0.002,
                    ),
                    Row(
                      key: Key('download done data widget'),
                      children: [
                        Text(
                          filesize(widget.model.bytesDone.toInt()),
                          style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                          ),
                        ),
                        Text(' / '),
                        Text(
                          filesize(widget.model.sizeBytes.toInt()),
                          style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.stop,
                            color: ThemeProvider.theme.primaryColor,
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            color: ThemeProvider.theme.primaryColor,
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
                color: ThemeProvider.theme.primaryColorLight,
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            fontWeight: FontWeight.bold),
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            fontWeight: FontWeight.bold),
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
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: hp * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Size'),
                          Text(filesize(widget.model.sizeBytes.toInt())),
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
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: OutlinedButton(
                          key: Key('Files button'),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                Routes.torrentContentScreenRoute,
                                arguments: TorrentContentPageArguments(
                                    hash: widget.model.hash,
                                    directory: widget.model.directory));
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            side: BorderSide(
                              width: 1.0,
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1!.color!,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_copy_rounded,
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Files",
                                style: TextStyle(
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.redAccent,
          icon: Icons.delete,
          onTap: () {
            deleteTorrent();
          },
        ),
      ],
    );
  }
}
