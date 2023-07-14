import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Blocs/sort_by_torrent_bloc/sort_by_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class SortByBottomSheet extends StatelessWidget {
  final int themeIndex;
  const SortByBottomSheet({Key? key, required this.themeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<SortByTorrentBloc, SortByTorrentState>(
      builder: (context, state) {
        var sortByTorrentBloc =
            BlocProvider.of<SortByTorrentBloc>(context, listen: false);
        return Container(
          key: Key('Sort by bottom sheet'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: ThemeBloc.theme(themeIndex).primaryColorLight,
          ),
          height: 500,
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(l10n.sort_by_heading,
                    style: TextStyle(
                        color: ThemeBloc.theme(themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  key: Key('Name ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_name,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.name
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetNameDirectionEvent(
                        nameDirection:
                            state.nameDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.name,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.nameDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Percent Complete ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_percent_completed,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.percentage
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetPercentageDirectionEvent(
                        percentageDirection: state.percentageDirection ==
                                SortByDirection.ascending
                            ? SortByDirection.descending
                            : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.percentage,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.percentageDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Download ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_downloaded,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.downloaded
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetDownloadedDirectionEvent(
                        downloadedDirection: state.downloadedDirection ==
                                SortByDirection.ascending
                            ? SortByDirection.descending
                            : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.downloaded,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.downloadedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Download Speed ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_download_speed,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.downSpeed
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetDownSpeedDirectionEvent(
                        downSpeedDirection: state.downSpeedDirection ==
                                SortByDirection.ascending
                            ? SortByDirection.descending
                            : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.downSpeed,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.downSpeedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Uploaded ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_uploaded,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.uploaded
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetUploadedDirectionEvent(
                        uploadedDirection:
                            state.uploadedDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.uploaded,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.uploadedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Upload Speed ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_upload_speed,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.upSpeed
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetUpSpeedDirectionEvent(
                        upSpeedDirection:
                            state.upSpeedDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.upSpeed,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.upSpeedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Ratio ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_ratio,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.ratio
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetRatioDirectionEvent(
                        ratioDirection:
                            state.ratioDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.ratio,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.ratioDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('File Size ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_file_size,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.fileSize
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetFileSizeDirectionEvent(
                        fileSizeDirection:
                            state.fileSizeDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.fileSize,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.fileSizeDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Peers ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_peers,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.peers
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetPeersDirectionEvent(
                        peersDirection:
                            state.peersDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.peers,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.peersDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Seeds ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_seeds,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.seeds
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetSeedsDirectionEvent(
                        seedsDirection:
                            state.seedsDirection == SortByDirection.ascending
                                ? SortByDirection.descending
                                : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.seeds,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.seedsDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Date Added ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_date_added,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.dateAdded
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetDateAddedDirectionEvent(
                        dateAddedDirection: state.dateAddedDirection ==
                                SortByDirection.ascending
                            ? SortByDirection.descending
                            : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.dateAdded,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.dateAddedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
                ListTile(
                  key: Key('Date Created ListTile'),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(
                        l10n.sort_by_date_created,
                        style: TextStyle(
                          color: state.sortByStatus == SortByValue.dateCreated
                              ? Colors.blue
                              : ThemeBloc.theme(themeIndex)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    sortByTorrentBloc.add(
                      SetDateCreatedDirectionEvent(
                        dateCreatedDirection: state.dateCreatedDirection ==
                                SortByDirection.ascending
                            ? SortByDirection.descending
                            : SortByDirection.ascending,
                      ),
                    );
                  },
                  trailing: sortIconButton(
                    sortByStatus: SortByValue.dateCreated,
                    sortByTorrentBloc: sortByTorrentBloc,
                    sortByDirection: state.dateCreatedDirection,
                    themeIndex: themeIndex,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget sortIconButton({
  required SortByValue sortByStatus,
  required SortByDirection sortByDirection,
  required SortByTorrentBloc sortByTorrentBloc,
  required int themeIndex,
}) {
  return Visibility(
    visible: sortByTorrentBloc.state.sortByStatus == sortByStatus,
    child: IconButton(
      icon: sortByDirection == SortByDirection.ascending
          ? Icon(FontAwesomeIcons.sortUp)
          : Icon(FontAwesomeIcons.sortDown),
      onPressed: () {},
      color: sortByTorrentBloc.state.sortByStatus == sortByStatus
          ? Colors.blue
          : ThemeBloc.theme(themeIndex).textTheme.bodyLarge?.color,
    ),
  );
}
