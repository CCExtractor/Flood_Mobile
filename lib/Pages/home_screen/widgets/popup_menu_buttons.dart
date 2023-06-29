import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Pages/widgets/add_tag_dialogue.dart';
import 'package:flood_mobile/Pages/widgets/delete_torrent_sheet.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopupMenuButtons extends StatefulWidget {
  final int themeIndex;
  const PopupMenuButtons({Key? key, required this.themeIndex})
      : super(key: key);

  @override
  State<PopupMenuButtons> createState() => _PopupMenuButtonsState();
}

class _PopupMenuButtonsState extends State<PopupMenuButtons> {
  @override
  Widget build(BuildContext context) {
    final MultipleSelectTorrentBloc selectedTorrent =
        BlocProvider.of<MultipleSelectTorrentBloc>(context);
    return PopupMenuButton<String>(
      color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
      icon: Icon(
        Icons.more_vert,
        color: ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
      ),
      onSelected: (value) {
        List<String> hash = [];
        List<int> index = [];
        selectedTorrent.state.selectedTorrentList.toList().forEach((element) {
          hash.add(element.hash);
        });
        if (value == 'Select All') {
          selectedTorrent.add(RemoveAllItemsFromListEvent());
          selectedTorrent.add(RemoveAllIndexFromListEvent());
          selectedTorrent.add(AddAllItemsToListEvent(
              models:
                  BlocProvider.of<HomeScreenBloc>(context).state.torrentList));
          for (int i = 0;
              i <
                  BlocProvider.of<HomeScreenBloc>(context)
                      .state
                      .torrentList
                      .length;
              i++) {
            index.add(i);
          }
          selectedTorrent.add(AddAllIndexToListEvent(index: index));
        }
        if (value == 'Start') {
          TorrentApi.startTorrent(hashes: hash, context: context);
          selectedTorrent.add(ChangeSelectionModeEvent());
        }
        if (value == 'Pause') {
          TorrentApi.stopTorrent(hashes: hash, context: context);
          selectedTorrent.add(ChangeSelectionModeEvent());
        }
        if (value == 'Delete') {
          deleteTorrent(
            context: context,
            indexes: selectedTorrent.state.selectedTorrentIndex,
            torrentModels: selectedTorrent.state.selectedTorrentList.toList(),
            themeIndex: widget.themeIndex,
          );
          selectedTorrent.add(ChangeSelectionModeEvent());
        }
        if (value == "Set Tags") {
          showDialog(
              context: context,
              builder: (context) => AddTagDialogue(
                    torrents:
                        selectedTorrent.state.selectedTorrentList.toList(),
                    themeIndex: widget.themeIndex,
                  )).then((value) {
            setState(() {
              selectedTorrent.add(ChangeSelectionModeEvent());
              selectedTorrent.add(RemoveAllIndexFromListEvent());
              selectedTorrent.add(RemoveAllItemsFromListEvent());
            });
          });
        }
      },
      itemBuilder: (BuildContext context) {
        return {
          'Select All',
          'Start',
          'Pause',
          'Delete',
          'Set Tags',
        }.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}
