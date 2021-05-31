import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flutter/material.dart';

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
              List<TorrentContentModel> torrentContentList = snapshot.data;
              return ListView.builder(
                itemCount: torrentContentList.length,
                itemBuilder: (context, index) {
                  return (snapshot.hasData && torrentContentList.length != 0)
                      ? Text(torrentContentList[index].filename)
                      : Center(
                          child: Text('Hello'),
                        );
                },
              );
            }
            return Text('Loading');
          },
        ),
      ),
    );
  }
}
