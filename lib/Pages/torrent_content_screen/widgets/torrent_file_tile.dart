import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Route/Arguments/video_stream_screen_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';

class TorrentFileTile extends StatefulWidget {
  final TorrentContentModel model;
  final double wp;
  final String hash;
  final int themeIndex;
  TorrentFileTile(
      {required this.model,
      required this.wp,
      required this.hash,
      required this.themeIndex});

  @override
  _TorrentFileTileState createState() => _TorrentFileTileState();
}

class _TorrentFileTileState extends State<TorrentFileTile> {
  bool isSelected = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!BlocProvider.of<TorrentContentScreenBloc>(context)
        .state
        .selectedIndexList
        .contains(widget.model.index)) {
      setState(() {
        isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentContentScreenBloc, TorrentContentScreenState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: (widget.model.depth) * 5.0),
          child: ListTile(
            onLongPress: () {
              setState(() {
                BlocProvider.of<TorrentContentScreenBloc>(context,
                        listen: false)
                    .add(SetSelectionModeEvent(newIsSelected: true));
              });
            },
            onTap: () {
              String fileType = widget.model.filename.split('.').last;
              if (fileType == 'mp4' ||
                  fileType == 'mkv' ||
                  fileType == 'webm' ||
                  fileType == 'mov' ||
                  fileType == 'mp3' ||
                  fileType == 'wav') {
                Navigator.of(context).pushNamed(
                  Routes.streamVideoScreenRoute,
                  arguments: VideoStreamScreenArguments(
                      hash: widget.hash,
                      index: widget.model.index.toString(),
                      themeIndex: widget.themeIndex),
                );
              }
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.model.filename,
                    style: TextStyle(
                      color: ThemeBloc.theme(widget.themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  filesize(widget.model.sizeBytes),
                  style: TextStyle(
                      color: ThemeBloc.theme(widget.themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontSize: 12),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.all(0),
                    lineHeight: 5.0,
                    percent: widget.model.percentComplete.roundToDouble() / 100,
                    backgroundColor: ThemeBloc.theme(widget.themeIndex)
                        .colorScheme
                        .secondary
                        .withAlpha(80),
                    progressColor: (widget.model.percentComplete
                                .toStringAsFixed(1) ==
                            '100.0')
                        ? ThemeBloc.theme(widget.themeIndex).primaryColorDark
                        : Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 40,
                ),
                Text(
                  widget.model.percentComplete.toStringAsFixed(1) + " %",
                  style: TextStyle(
                    color: ThemeBloc.theme(widget.themeIndex)
                        .textTheme
                        .bodyLarge
                        ?.color,
                  ),
                ),
              ],
            ),
            leading: (!BlocProvider.of<TorrentContentScreenBloc>(context)
                    .state
                    .isSelectionMode)
                ? Icon(
                    (widget.model.isMediaFile)
                        ? Icons.ondemand_video
                        : Icons.insert_drive_file_outlined,
                    color: ThemeBloc.theme(widget.themeIndex)
                        .textTheme
                        .bodyLarge
                        ?.color,
                  )
                : Checkbox(
                    side: BorderSide(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .iconTheme
                            .color!),
                    hoverColor: ThemeBloc.theme(widget.themeIndex)
                        .textTheme
                        .bodyLarge
                        ?.color,
                    value: isSelected,
                    activeColor:
                        ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                    onChanged: (bool? value) {
                      setState(() {
                        isSelected = value ?? false;
                      });
                      if (value == true) {
                        BlocProvider.of<TorrentContentScreenBloc>(context,
                                listen: false)
                            .add(
                          AddItemToSelectedIndexEvent(
                              index: widget.model.index),
                        );
                      } else {
                        BlocProvider.of<TorrentContentScreenBloc>(context,
                                listen: false)
                            .add(
                          RemoveItemFromSelectedListEvent(
                              index: widget.model.index),
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
