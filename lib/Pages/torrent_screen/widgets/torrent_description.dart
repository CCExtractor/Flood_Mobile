import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/Pages/torrent_screen/services/date_converter.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';

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
                  color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: hp * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_date_added),
                Text(dateConverter(timestamp: model.dateAdded.toInt())),
              ],
            ),
            SizedBox(
              height: hp * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_date_created),
                Text(dateConverter(timestamp: model.dateCreated.toInt())),
              ],
            ),
            SizedBox(
              height: hp * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_location),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: wp * 0.1),
                    child: Text(model.directory),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: hp * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.torrents_add_tags,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: wp * 0.17),
                    child: Text((model.tags.length != 0)
                        ? model.tags.toList().toString()
                        : l10n.torrent_description_tags_none),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: hp * 0.03,
            ),
            Text(
              l10n.torrent_description_transfer,
              style: TextStyle(
                  color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: hp * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_peers),
                Text(model.peersConnected.toInt().toString() +
                    l10n.torrent_description_connected_of +
                    model.peersTotal.toInt().toString()),
              ],
            ),
            SizedBox(
              height: hp * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_seeds),
                Text(model.seedsConnected.toInt().toString() +
                    l10n.torrent_description_connected_of +
                    model.seedsTotal.toInt().toString()),
              ],
            ),
            SizedBox(
              height: hp * 0.03,
            ),
            Text(
              l10n.menu_torrent_lable,
              style: TextStyle(
                  color: ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: hp * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.torrent_description_size),
                Text(filesize(model.sizeBytes.toInt())),
              ],
            ),
            SizedBox(
              height: hp * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.torrent_description_type,
                ),
                Text(model.isPrivate
                    ? l10n.torrent_description_type_private
                    : l10n.torrent_description_type_public),
              ],
            ),
            SizedBox(
              height: 20,
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
                          themeIndex: themeIndex));
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  side: BorderSide(
                    width: 1.0,
                    color:
                        ThemeBloc.theme(themeIndex).textTheme.bodyLarge!.color!,
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
  }
}
