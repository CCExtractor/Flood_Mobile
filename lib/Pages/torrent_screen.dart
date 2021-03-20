import 'package:flood_mobile/Api/api_requests.dart';
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
        title: Text('Torrent'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: ElevatedButton(
            child: Text('REQUEST'),
            onPressed: () {
              ApiRequests api = new ApiRequests();
              api.getTorrentList();
            },
            style: ButtonStyle(),
          ),
        ),
      ),
    );
  }
}
