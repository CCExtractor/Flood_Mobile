import 'package:dio/dio.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/add_trackers_dialogue.dart';
import 'package:flood_mobile/Pages/widgets/delete_torrent_sheet.dart';
import 'package:flood_mobile/Pages/widgets/toast_component.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Pages/widgets/add_tag_dialogue.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:focused_menu/modals.dart';
import 'package:permission_handler/permission_handler.dart';

List<FocusedMenuItem> getFocusedMenuItems(BuildContext context,
    List<int> indexes, TorrentModel model, int themeIndex) {
  final UserInterfaceModel userInterfaceModel =
      BlocProvider.of<UserInterfaceBloc>(context).state.model;
  return [
    // Select All Torrents
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
    // Set Tags for Torrents
    if (userInterfaceModel.showSetTags)
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
    // Check Hash
    if (userInterfaceModel.showCheckHash)
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
    // Reannounce
    if (userInterfaceModel.showReannounce)
      FocusedMenuItem(
        title: Text(
          context.l10n.torrents_reannounce,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailingIcon: Icon(
          FontAwesomeIcons.bullhorn,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () async {
          bool result = await TorrentApi.reannounceTorrents(
              hashes: [model.hash], context: context);
          if (result) {
            final reannounceSnackbar = addFloodSnackBar(
                SnackbarType.success,
                context.l10n.torrents_reannounce_snackbar,
                context.l10n.button_dismiss);

            ScaffoldMessenger.of(context).showSnackBar(reannounceSnackbar);
          } else {
            final addTorrentSnackbar = addFloodSnackBar(
                SnackbarType.caution,
                context.l10n.torrents_reannounce_problem_snackbar,
                context.l10n.button_dismiss);

            ScaffoldMessenger.of(context).showSnackBar(addTorrentSnackbar);
          }
        },
      ),
    if (userInterfaceModel.showSetTrackers)
      FocusedMenuItem(
        title: Text(
          context.l10n.torrents_set_trackers_heading,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailingIcon: Icon(
          FontAwesomeIcons.tags,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () async {
          List<String> trackers = await TorrentApi.getTrackersList(
              context: context, hash: model.hash);
          showDialog(
            context: context,
            builder: (context) => AddTrackersDialogue(
              torrents: [model],
              themeIndex: themeIndex,
              trackers: trackers,
            ),
          );
        },
      ),

    if (userInterfaceModel.showGenerateMagnetLink)
      FocusedMenuItem(
          title: Text(
            context.l10n.torrents_genrate_magnet_link,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailingIcon: Icon(
            FontAwesomeIcons.link,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    key: Key("Magnet link dialogue"),
                    backgroundColor:
                        ThemeBloc.theme(themeIndex).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    title: Text(context.l10n.torrents_magnet_link),
                    content: Text("magnet:?xt=urn:btih:${model.hash}"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.l10n.button_close),
                      ),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: "magnet:?xt=urn:btih:${model.hash}"));
                          Navigator.pop(context);
                        },
                        child: Text(context.l10n.button_copy),
                      ),
                    ],
                  );
                });
          }),
    if (userInterfaceModel.showPriority)
      FocusedMenuItem(
        title: Text(
          "Set Priority",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        trailingIcon: Icon(
          Icons.file_upload_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SetPriorityDiagloge(themeIndex: themeIndex, model: model);
            },
          );
        },
      ),
    if (userInterfaceModel.showInitialSeeding)
      FocusedMenuItem(
        title: Text(context.l10n.torrents_initial_seeding),
        onPressed: () async {
          await TorrentApi.updateInitialSeeding(
              updatedValue: !model.isInitialSeeding,
              context: context,
              hash: model.hash);
        },
        trailingIcon: Icon(
          model.isInitialSeeding
              ? FontAwesomeIcons.checkSquare
              : FontAwesomeIcons.square,
          color: Colors.black,
          size: 20,
        ),
      ),
    if (userInterfaceModel.showSequentialDownload)
      FocusedMenuItem(
        title: Text(context.l10n.torrents_sequential_download),
        onPressed: () async {
          await TorrentApi.updateSequentialMode(
              updatedValue: !model.isSequential,
              context: context,
              hash: model.hash);
        },
        trailingIcon: Icon(
          model.isSequential
              ? FontAwesomeIcons.checkSquare
              : FontAwesomeIcons.square,
          color: Colors.black,
          size: 20,
        ),
      ),
    if (userInterfaceModel.showDownloadTorrent)
      FocusedMenuItem(
        title: Text(context.l10n.torrents_download_torrent),
        onPressed: () async {
          try {
            final status = await Permission.storage.request();
            if (status.isGranted) {
              await downloadFile(
                "${BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl}/api/torrents/${model.hash}/metainfo",
                "/storage/emulated/0/Download/Flood-Mobile/${model.name}.torrent",
                context,
                model,
              );
            } else {
              Toasts.showFailToast(msg: context.l10n.toast_permission_denied);
            }
          } catch (error) {
            print(error);
          }
        },
        trailingIcon: Icon(
          FontAwesomeIcons.fileDownload,
          color: Colors.black,
          size: 20,
        ),
      ),
    if (userInterfaceModel.showDelete)
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

class SetPriorityDiagloge extends StatefulWidget {
  final int themeIndex;
  final TorrentModel model;
  const SetPriorityDiagloge(
      {Key? key, required this.themeIndex, required this.model})
      : super(key: key);
  @override
  State<SetPriorityDiagloge> createState() => _SetPriorityDiaglogeState();
}

class _SetPriorityDiaglogeState extends State<SetPriorityDiagloge> {
  late double _sliderValue;
  @override
  void initState() {
    _sliderValue = widget.model.priority.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    return AlertDialog(
      key: Key("Set priority dialogue"),
      backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      title: Text(context.l10n.set_priority_heading),
      content: Container(
        height: hp * 0.05,
        child: Slider(
          value: _sliderValue,
          min: 0,
          max: 3,
          divisions: 3,
          onChanged: (double value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.button_close),
        ),
        TextButton(
          onPressed: () async {
            await TorrentApi.updatePriority(
              hashes: [widget.model.hash],
              priority: _sliderValue.round(),
              context: context,
            );
            Navigator.pop(context);
            final reannounceSnackbar = addFloodSnackBar(
              SnackbarType.success,
              context.l10n.set_priority_snackbar,
              context.l10n.button_dismiss,
            );

            ScaffoldMessenger.of(context).showSnackBar(reannounceSnackbar);
          },
          child: Text(context.l10n.button_set),
        ),
      ],
    );
  }
}

Future<void> downloadFile(String url, String savePath, BuildContext context,
    TorrentModel model) async {
  Dio dio = Dio();
  dio.options.headers['Accept'] = "application/json";
  dio.options.headers['Content-Type'] = "application/json";
  dio.options.headers['Connection'] = "keep-alive";
  dio.options.headers['Cookie'] =
      BlocProvider.of<UserDetailBloc>(context, listen: false).token;
  try {
    await dio.download(url, savePath);
    final downloadSnackbar = addFloodSnackBar(
      SnackbarType.success,
      context.l10n.torrents_donwload_file_snackbar,
      context.l10n.button_dismiss,
    );

    ScaffoldMessenger.of(context).showSnackBar(downloadSnackbar);
  } catch (e) {
    final downloadSnackbar = addFloodSnackBar(
      SnackbarType.success,
      context.l10n.torrents_donwload_file_fail_snackbar,
      context.l10n.button_dismiss,
    );
    ScaffoldMessenger.of(context).showSnackBar(downloadSnackbar);
    print('Failed to download file. Error: $e');
  }
}
