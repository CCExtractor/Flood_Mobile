import 'package:flood_mobile/Api/api_requests.dart';
import 'package:flood_mobile/Constants/AppColor.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/material.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColor.primaryColor,
      child: StreamBuilder(
        stream: ApiRequests.getAllTorrents(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TorrentModel>> snapshot) {
          return (snapshot.hasData && snapshot.data.length != 0)
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].percentComplete
                              .toStringAsFixed(2) +
                          " %"),
                      onTap: () => print("ListTile"),
                    );
                  },
                )
              : Container();
        },
      ),
    );
  }
}
