import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/widgets/delete_torrent_sheet.dart';
import 'package:flood_mobile/l10n/l10n.dart';
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
            ? context.l10n.unselect_torrent
            : context.l10n.select_torrent,
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
        context.l10n.torrents_set_tags_heading,
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
        context.l10n.torrent_check_hash,
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
              SnackbarType.success,
              context.l10n.torrent_check_hash_success,
              context.l10n.button_dismiss);

          ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
        } else {
          if (kDebugMode) print("Error check hash failed");
          final addTorrentSnackbar = addFloodSnackBar(
              SnackbarType.caution,
              context.l10n.torrent_check_hash_failed,
              context.l10n.button_dismiss);

          ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
        }
      },
    ),
    FocusedMenuItem(
      backgroundColor: Colors.redAccent,
      title: Text(
        context.l10n.button_delete,
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
