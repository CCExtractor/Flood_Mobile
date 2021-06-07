import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Components/torrent_content_tile.dart';
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
