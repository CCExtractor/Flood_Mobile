import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Pages/torrent_screen/services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TorrentDescription extends StatelessWidget {
  final TorrentModel model;
  final int themeIndex;
  final double hp;
  final double wp;
  const TorrentDescription({
    Key? key,
    required this.model,
    required this.themeIndex,
    required this.hp,
    required this.wp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<UserInterfaceBloc, UserInterfaceState>(
      builder: (context, state) {
        return Card(
          color: ThemeBloc.theme(themeIndex).primaryColorLight,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                ),
                Text(
                  l10n.torrent_description_general,
                  style: TextStyle(
                      color: ThemeBloc.theme(themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: hp * 0.01,
                ),
                if (state.model.showDateAdded)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_date_added,
                    rightText:
                        dateConverter(timestamp: model.dateAdded.toInt()),
                  ),
                if (state.model.showDateCreated)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_date_created,
                    rightText:
                        dateConverter(timestamp: model.dateCreated.toInt()),
                  ),
                if (state.model.showRatio)
                  torrentDescriptionRow(
                    leftText: context.l10n.torrent_description_ratio,
                    rightText: model.ratio.toStringAsFixed(2),
                  ),
                if (state.model.showLocation)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_location,
                    rightText: model.directory,
                  ),
                if (state.model.showTags)
                  torrentDescriptionRow(
                    leftText: l10n.torrents_add_tags,
                    rightText: (model.tags.length != 0)
                        ? model.tags.toList().toString()
                        : l10n.torrent_description_tags_none,
                  ),
                if (state.model.showTrackers)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_trackers,
                    rightText: (model.trackerURIs.length != 0)
                        ? model.trackerURIs.toList().toString()
                        : l10n.torrent_description_trackers_none,
                  ),
                if (state.model.showTrackersMessage)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_trackers_message,
                    rightText: model.message.isEmpty
                        ? l10n.torrent_description_trackers_none
                        : model.message,
                  ),
                SizedBox(
                  height: hp * 0.025,
                ),
                Text(
                  l10n.torrent_description_transfer,
                  style: TextStyle(
                      color: ThemeBloc.theme(themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: hp * 0.01,
                ),
                if (state.model.showDownloadSpeed)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_download_speed,
                    rightText: "${filesize(model.downRate.round())}/s",
                  ),
                if (state.model.showUploadSpeed)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_upload_speed,
                    rightText: "${filesize(model.upRate.round())}/s",
                  ),
                if (state.model.showPeers)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_peers,
                    rightText: model.peersConnected.toInt().toString() +
                        l10n.torrent_description_connected_of +
                        model.peersTotal.toInt().toString(),
                  ),
                if (state.model.showSeeds)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_seeds,
                    rightText: model.seedsConnected.toInt().toString() +
                        l10n.torrent_description_connected_of +
                        model.seedsTotal.toInt().toString(),
                  ),
                SizedBox(
                  height: hp * 0.025,
                ),
                Text(
                  l10n.menu_torrent_lable,
                  style: TextStyle(
                      color: ThemeBloc.theme(themeIndex)
                          .textTheme
                          .bodyLarge
                          ?.color,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: hp * 0.01,
                ),
                if (state.model.showSize)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_size,
                    rightText: filesize(model.sizeBytes.toInt()),
                  ),
                if (state.model.showType)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_type,
                    rightText: model.isPrivate
                        ? l10n.torrent_description_type_private
                        : l10n.torrent_description_type_public,
                  ),
                if (state.model.showHash)
                  torrentDescriptionRow(
                    leftText: l10n.torrent_description_hash,
                    rightText: model.hash,
                  ),
                SizedBox(
                  height: hp * 0.025,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: OutlinedButton(
                    key: Key('Files button'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.torrentContentScreenRoute,
                        arguments: TorrentContentPageArguments(
                          hash: model.hash,
                          directory: model.directory,
                          themeIndex: themeIndex,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      side: BorderSide(
                        width: 1.0,
                        color: ThemeBloc.theme(themeIndex)
                            .textTheme
                            .bodyLarge!
                            .color!,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_copy_rounded,
                          color: ThemeBloc.theme(themeIndex)
                              .textTheme
                              .bodyLarge
                              ?.color,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          l10n.torrent_description_Files,
                          style: TextStyle(
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget torrentDescriptionRow({
    required String leftText,
    required String rightText,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leftText),
            SizedBox(width: 20),
            Flexible(child: Text(rightText, textAlign: TextAlign.end)),
          ],
        ),
        SizedBox(
          height: hp * 0.005,
        ),
      ],
    );
  }
}
