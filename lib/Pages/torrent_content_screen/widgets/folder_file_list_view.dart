import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Pages/torrent_content_screen/widgets/torrent_file_tile.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FolderFileListView extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  final double depth;
  final String hash;
  final int themeIndex;

  FolderFileListView(
      {required this.data,
      required this.depth,
      required this.hash,
      required this.themeIndex});

  @override
  _FolderFileListViewState createState() => _FolderFileListViewState();
}

class _FolderFileListViewState extends State<FolderFileListView> {
  List<String> folderList = [];

  @override
  void initState() {
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
                    hash: widget.hash,
                    themeIndex: widget.themeIndex,
                  )
                : Padding(
                    padding: EdgeInsets.only(left: widget.depth * 10),
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          BlocProvider.of<TorrentContentScreenBloc>(context,
                                  listen: false)
                              .add(SetSelectionModeEvent(newIsSelected: true));
                        });
                      },
                      child: ExpansionTileCard(
                        elevation: 0,
                        expandedColor:
                            ThemeBloc.theme(widget.themeIndex).primaryColor,
                        baseColor:
                            ThemeBloc.theme(widget.themeIndex).primaryColor,
                        leading: Icon(
                          Icons.folder_rounded,
                          color: ThemeBloc.theme(widget.themeIndex)
                              .iconTheme
                              .color,
                        ),
                        title: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            folderList[index],
                            style: TextStyle(
                              color: ThemeBloc.theme(widget.themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        children: [
                          FolderFileListView(
                            data: widget.data[folderList[index]],
                            depth: widget.depth + 1,
                            hash: widget.hash,
                            themeIndex: widget.themeIndex,
                          )
                        ],
                      ),
                    ),
                  )
            : SpinKitFadingCircle(
                color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
              );
      },
    );
  }
}
