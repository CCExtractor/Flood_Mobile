import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flutter/material.dart';

import 'flood_snackbar.dart';

class DeleteTorrentSheet extends StatefulWidget {
  final List<TorrentModel> torrents;

  DeleteTorrentSheet({required this.torrents});

  @override
  _DeleteTorrentSheetState createState() => _DeleteTorrentSheetState();
}

class _DeleteTorrentSheetState extends State<DeleteTorrentSheet> {
  bool deleteWithData = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Text(
            'Delete Torrent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.torrents.length > 1
                ? 'Are you sure you want to delete ${widget.torrents.length} torrents?'
                : 'Are you sure you want to delete the torrent?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                key: Key('Checkbox delete with data'),
                value: deleteWithData,
                activeColor: ThemeProvider.theme.primaryColorDark,
                onChanged: (bool? value) {
                  print(value);
                  setState(() {
                    deleteWithData = value ?? false;
                  });
                },
              ),
              Text(
                'Delete with data',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      primary: Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      List<String> hashes = [];
                      widget.torrents.forEach((element) {
                        hashes.add(element.hash);
                      });
                      TorrentApi.deleteTorrent(
                          hashes: hashes,
                          deleteWithData: deleteWithData,
                          context: context);
                      Navigator.of(context).pop();

                      final deleteTorrentSnackBar = addFloodSnackBar(
                          SnackbarType.caution,
                          'Torrent deleted successfuly',
                          'Dismiss');
                      ScaffoldMessenger.of(context)
                          .showSnackBar(deleteTorrentSnackBar);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      primary: ThemeProvider.theme.primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
