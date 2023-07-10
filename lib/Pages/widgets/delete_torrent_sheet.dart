import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';

class DeleteTorrentSheet extends StatefulWidget {
  final int themeIndex;
  final List<TorrentModel> torrents;
  final List<int> indexes;

  DeleteTorrentSheet(
      {required this.torrents,
      required this.indexes,
      required this.themeIndex});

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
            context.l10n.delete_torrent,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.torrents.length > 1
                ? context.l10n.multi_torrent_delete_info(widget.torrents.length)
                : context.l10n.single_torrent_delete_info,
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
                activeColor:
                    ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                onChanged: (bool? value) {
                  setState(() {
                    deleteWithData = value ?? false;
                  });
                },
              ),
              Text(
                context.l10n.delete_with_data_text,
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
                      backgroundColor: Colors.grey,
                    ),
                    child: Center(
                      child: Text(
                        context.l10n.button_no,
                        style: TextStyle(
                          color: ThemeBloc.theme(widget.themeIndex)
                              .textTheme
                              .bodyLarge
                              ?.color,
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
                          id: widget.indexes,
                          hashes: hashes,
                          deleteWithData: deleteWithData,
                          context: context);
                      Navigator.of(context).pop();

                      final deleteTorrentSnackBar = addFloodSnackBar(
                          SnackbarType.caution,
                          context.l10n.torrent_delete_snackbar,
                          context.l10n.button_dismiss);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(deleteTorrentSnackBar);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      backgroundColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                    ),
                    child: Center(
                      child: Text(
                        context.l10n.button_yes,
                        style: TextStyle(
                          color: ThemeBloc.theme(widget.themeIndex)
                              .textTheme
                              .bodyLarge
                              ?.color,
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

void deleteTorrent({
  required BuildContext context,
  required List<int> indexes,
  required List<TorrentModel> torrentModels,
  required int themeIndex,
}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    context: context,
    backgroundColor: ThemeBloc.theme(themeIndex).scaffoldBackgroundColor,
    builder: (context) {
      return DeleteTorrentSheet(
        torrents: torrentModels,
        themeIndex: themeIndex,
        indexes: indexes,
      );
    },
  );
}
