import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/widgets/delete_torrent_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Pages/widgets/add_tag_dialogue.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:focused_menu/modals.dart';

List<FocusedMenuItem> getFocusedMenuItems(BuildContext context,
    List<int> indexes, TorrentModel model, int themeIndex) {
  return [
    FocusedMenuItem(
      title: Text(
        BlocProvider.of<MultipleSelectTorrentBloc>(context)
                .state
                .isSelectionMode
            ? 'Unselect Torrent'
            : 'Select Torrent',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      trailingIcon: Icon(
        FontAwesomeIcons.solidFile,
        color: Colors.black,
        size: 18,
      ),
      onPressed: () {
        var selectTorrent = BlocProvider.of<MultipleSelectTorrentBloc>(context);
        selectTorrent.add(ChangeSelectionModeEvent());
        selectTorrent.add(RemoveAllItemsFromListEvent());
        selectTorrent.add(RemoveAllIndexFromListEvent());
        selectTorrent.add(AddItemToListEvent(model: model));
        selectTorrent.add(AddIndexToListEvent(index: indexes));
      },
    ),
    FocusedMenuItem(
      title: Text(
        'Set Tags',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      trailingIcon: Icon(
        FontAwesomeIcons.tags,
        color: Colors.black,
        size: 18,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddTagDialogue(
            torrents: [model],
            themeIndex: themeIndex,
          ),
        );
      },
    ),
    FocusedMenuItem(
      title: Text(
        'Check Hash',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      trailingIcon: Icon(
        Icons.tag,
        color: Colors.black,
      ),
      onPressed: () async {
        var result = await TorrentApi.checkTorrentHash(
            hashes: [model.hash], context: context);
        if (result) {
          if (kDebugMode) print("check hash performed successfully");
          final addTorrentSnackbar = addFloodSnackBar(
              SnackbarType.success, 'Hash check successful', 'Dismiss');

          ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
        } else {
          if (kDebugMode) print("Error check hash failed");
          final addTorrentSnackbar = addFloodSnackBar(
              SnackbarType.caution, 'Torrent hash failed', 'Dismiss');

          ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
        }
      },
    ),
    FocusedMenuItem(
      backgroundColor: Colors.redAccent,
      title: Text(
        'Delete',
      ),
      trailingIcon: Icon(
        Icons.delete,
        color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
      ),
      onPressed: () {
        deleteTorrent(
          context: context,
          indexes: indexes,
          torrentModels: [model],
          themeIndex: themeIndex,
        );
      },
    ),
  ];
}
