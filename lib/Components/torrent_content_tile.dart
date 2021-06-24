import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Provider/torrent_content_provider.dart';
import 'package:flood_mobile/Route/Arguments/video_stream_screen_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class FolderFileListView extends StatefulWidget {
  Map<dynamic, dynamic> data;
  double depth;
  String hash;

  FolderFileListView(
      {@required this.data, @required this.depth, @required this.hash});

  @override
  _FolderFileListViewState createState() => _FolderFileListViewState();
}

class _FolderFileListViewState extends State<FolderFileListView> {
  List<String> folderList = [];

  @override
  void initState() {
    // TODO: implement initState
    widget.data.forEach((key, value) {
      folderList.add(key);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wp = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: folderList.length,
      itemBuilder: (context, index) {
        return (folderList.length != 0)
            ? (widget.data[folderList[index]] is TorrentContentModel)
                ? TorrentFileTile(
                    model: widget.data[folderList[index]],
                    wp: wp,
                    hash: widget.hash)
                : Padding(
                    padding: EdgeInsets.only(left: widget.depth * 10),
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          Provider.of<TorrentContentProvider>(context,
                                  listen: false)
                              .setSelectionMode();
                        });
                      },
                      child: ExpansionTileCard(
                        elevation: 0,
                        expandedColor: AppColor.primaryColor,
                        baseColor: AppColor.primaryColor,
                        leading: Icon(
                          Icons.folder_rounded,
                        ),
                        title: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            folderList[index],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        children: [
                          FolderFileListView(
                            data: widget.data[folderList[index]],
                            depth: widget.depth + 1,
                            hash: widget.hash,
                          )
                        ],
                      ),
                    ),
                  )
            : SpinKitFadingCircle(
                color: AppColor.greenAccentColor,
              );
      },
    );
  }
}

class TorrentFileTile extends StatefulWidget {
  TorrentContentModel model;
  double wp;
  String hash;

  TorrentFileTile(
      {@required this.model, @required this.wp, @required this.hash});

  @override
  _TorrentFileTileState createState() => _TorrentFileTileState();
}

class _TorrentFileTileState extends State<TorrentFileTile> {
  bool isSelected = false;

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    if (!Provider.of<TorrentContentProvider>(context)
        .selectedIndexList
        .contains(widget.model.index)) {
      setState(() {
        isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TorrentContentProvider>(builder: (context, model, child) {
      return Padding(
        padding: EdgeInsets.only(left: (widget.model.depth) * 5.0),
        child: ListTile(
          onTap: () {
            String fileType = widget.model.filename.split('.').last;
            if (fileType == 'mp4') {
              Navigator.of(context).pushNamed(
                Routes.streamVideoScreenRoute,
                arguments: VideoStreamScreenArguments(
                  hash: widget.hash,
                  index: widget.model.index.toString(),
                ),
              );
            }
          },
          title: Row(
            children: [
              Expanded(
                child: Text(widget.model.filename),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                filesize(widget.model.sizeBytes),
                style: TextStyle(color: AppColor.textColor, fontSize: 12),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  padding: EdgeInsets.all(0),
                  lineHeight: 5.0,
                  percent: widget.model.percentComplete.roundToDouble() / 100,
                  backgroundColor: AppColor.blueAccentColor.withAlpha(80),
                  progressColor:
                      (widget.model.percentComplete.toStringAsFixed(1) ==
                              '100.0')
                          ? AppColor.greenAccentColor
                          : Colors.blue,
                ),
              ),
              SizedBox(
                width: 30,
                height: 40,
              ),
              Text(widget.model.percentComplete.toStringAsFixed(1) + " %"),
            ],
          ),
          leading: (!model.isSelectionMode)
              ? Icon((widget.model.isMediaFile)
                  ? Icons.ondemand_video
                  : Icons.insert_drive_file_outlined)
              : Checkbox(
                  value: isSelected,
                  activeColor: AppColor.greenAccentColor,
                  onChanged: (value) {
                    setState(() {
                      isSelected = value;
                    });
                    if (value == true) {
                      model.addItemToSelectedIndex(widget.model.index);
                    } else {
                      model.removeItemFromSelectedList(widget.model.index);
                    }
                  },
                ),
        ),
      );
    });
  }
}
