import 'package:flood_mobile/Api/api_requests.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/material.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flood'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder(
          stream: ApiRequests.getAllTorrents(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TorrentModel>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].percentComplete
                            .toStringAsFixed(2) +
                        " %"),
                    onTap: () => print("ListTile"));
              },
            );
          },
        ),
      ),
      // Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   child: Center(
      //     child: ElevatedButton(
      //       child: Text('Request'),
      //       onPressed: () {
      //         ApiRequests api = new ApiRequests();
      //         api.getTorrentList();
      //       },
      //       style: ButtonStyle(),
      //     ),
      //   ),
      // )
    );
  }
}
