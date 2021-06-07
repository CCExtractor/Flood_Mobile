import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FolderFileListView extends StatefulWidget {
  Map<dynamic, dynamic> data;
  double depth;

  FolderFileListView({@required this.data, @required this.depth});

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
                ? TorrentFileTile(model: widget.data[folderList[index]], wp: wp)
                : Padding(
                    padding: EdgeInsets.only(left: widget.depth * 10),
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
                        )
                      ],
                    ),
                  )
            : SpinKitFadingCircle(
                color: AppColor.greenAccentColor,
              );
      },
    );
  }
}

class TorrentFileTile extends StatelessWidget {
  TorrentContentModel model;
  double wp;

  TorrentFileTile({@required this.model, @required this.wp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (model.depth) * 10.0),
      child: ListTile(
        onTap: () {
          String fileType = model.filename.split('.').last;
          if (fileType == 'mp4') {
            Navigator.of(context).pushNamed(Routes.streamVideoScreenRoute);
          }
        },
        title: Row(
          children: [
            Expanded(
              child: Text(model.filename),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              filesize(model.sizeBytes),
              style: TextStyle(color: AppColor.textColor, fontSize: 12),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            LinearPercentIndicator(
              padding: EdgeInsets.all(0),
              width: wp * 0.5,
              lineHeight: 5.0,
              percent: model.percentComplete.roundToDouble() / 100,
              backgroundColor: AppColor.blueAccentColor.withAlpha(80),
              progressColor:
                  (model.percentComplete.toStringAsFixed(1) == '100.0')
                      ? AppColor.greenAccentColor
                      : Colors.blue,
            ),
            SizedBox(
              width: 10,
              height: 40,
            ),
            Text(model.percentComplete.toStringAsFixed(1) + " %"),
          ],
        ),
        leading: Icon((model.isMediaFile)
            ? Icons.ondemand_video
            : Icons.insert_drive_file_outlined),
      ),
    );
  }
}
