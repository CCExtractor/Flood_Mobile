import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TorrentContentScreen extends StatefulWidget {
  TorrentContentPageArguments arguments;

  TorrentContentScreen({@required this.arguments});

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
        child: StreamBuilder(
          stream: TorrentApi.getTorrentContent(
              context: context, hash: widget.arguments.hash),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              List<String> folderList = [];
              Map<String, dynamic> data = snapshot.data;
              data.forEach((key, value) {
                folderList.add(key);
              });
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Files',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.storage),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              widget.arguments.directory,
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColor.greenAccentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    FolderFileListView(
                      data: snapshot.data,
                      depth: 0,
                    ),
                  ],
                ),
              );
            }
            return SpinKitFadingCircle(
              color: AppColor.greenAccentColor,
            );
          },
        ),
      ),
    );
  }
}

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
                ? Padding(
                    padding: EdgeInsets.only(left: (widget.depth) * 10.0),
                    child: ListTile(
                      onTap: () {},
                      title: Row(
                        children: [
                          Expanded(
                            child:
                                Text(widget.data[folderList[index]].filename),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            filesize(
                              widget.data[folderList[index]].sizeBytes,
                            ),
                            style: TextStyle(
                                color: AppColor.textColor, fontSize: 12),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          LinearPercentIndicator(
                            padding: EdgeInsets.all(0),
                            width: wp * 0.5,
                            lineHeight: 5.0,
                            percent: widget
                                    .data[folderList[index]].percentComplete
                                    .roundToDouble() /
                                100,
                            backgroundColor:
                                AppColor.blueAccentColor.withAlpha(80),
                            progressColor: (widget
                                        .data[folderList[index]].percentComplete
                                        .toStringAsFixed(1) ==
                                    '100.0')
                                ? AppColor.greenAccentColor
                                : Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                            height: 40,
                          ),
                          Text(widget.data[folderList[index]].percentComplete
                                  .toStringAsFixed(1) +
                              " %"),
                        ],
                      ),
                      leading: Icon((widget.data[folderList[index]].isMediaFile)
                          ? Icons.ondemand_video
                          : Icons.insert_drive_file_outlined),
                    ),
                  )
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
