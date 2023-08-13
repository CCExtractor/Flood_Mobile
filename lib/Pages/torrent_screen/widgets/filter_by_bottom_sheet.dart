import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class FilterByStatus extends StatefulWidget {
  final int themeIndex;

  const FilterByStatus({Key? key, required this.themeIndex}) : super(key: key);
  @override
  _FilterByStatusState createState() => _FilterByStatusState();
}

class _FilterByStatusState extends State<FilterByStatus> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<FilterTorrentBloc, FilterTorrentState>(
      builder: (context, state) {
        final filterModel = BlocProvider.of<FilterTorrentBloc>(context);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
          ),
          height: 500,
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(l10n.filter_status_title,
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  leading: Icon(
                    Icons.star_sharp,
                    size: 20,
                    color:
                        state.filterStatus.toString().split(".").last == "all"
                            ? Colors.blue
                            : ThemeBloc.theme(widget.themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(context.l10n.filter_all,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              BlocProvider.of<HomeScreenBloc>(context)
                                  .state
                                  .torrentList
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "all"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Downloading Torrent ListTile'),
                  leading: Icon(
                    Icons.download_sharp,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "downloading"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_downloading,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "downloading"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys
                                      .toList()
                                      .contains('downloading')
                                  ? state.mapStatus['downloading'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "downloading"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.downloading,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Seeding Torrent ListTile'),
                  leading: Icon(
                    Icons.upload_sharp,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "seeding"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_seeding,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "seeding"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('seeding')
                                  ? state.mapStatus['seeding'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "seeding"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.seeding,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Complete Torrent ListTile'),
                  leading: Icon(
                    Icons.done,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "complete"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_completed,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "complete"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('complete')
                                  ? state.mapStatus['complete'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "complete"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.complete,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Stopped Torrent ListTile'),
                  leading: Icon(
                    Icons.stop,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "stopped"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_stopped,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "stopped"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('stopped')
                                  ? state.mapStatus['stopped'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "stopped"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.stopped,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Active Torrent ListTile'),
                  leading: Icon(
                    Icons.trending_up_outlined,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "active"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_active,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "active"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('active')
                                  ? state.mapStatus['active'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "active"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.active,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Inactive Torrent ListTile'),
                  leading: Icon(
                    Icons.trending_down_outlined,
                    size: 20,
                    color: state.filterStatus.toString().split(".").last ==
                            "inactive"
                        ? Colors.blue
                        : ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_inactive,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "inactive"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('inactive')
                                  ? state.mapStatus['inactive'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "inactive"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.inactive,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  key: Key('Error Torrent ListTile'),
                  leading: Icon(
                    Icons.error,
                    size: 20,
                    color:
                        state.filterStatus.toString().split(".").last == "error"
                            ? Colors.blue
                            : ThemeBloc.theme(widget.themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_status_error,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "error"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              state.mapStatus.keys.toList().contains('error')
                                  ? state.mapStatus['error'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "error"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.error,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(l10n.filter_tag_title,
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_all,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              BlocProvider.of<HomeScreenBloc>(context)
                                  .state
                                  .torrentList
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "all"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.mapTags.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.mapTags.keys.toList()[index] != 'Untagged') {
                        return ListTile(
                          minLeadingWidth: 2,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -2),
                          title: Row(
                            children: [
                              Flexible(
                                child: Text(state.mapTags.keys.toList()[index],
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: state.mapTags.keys
                                                    .toList()[index] ==
                                                state.tagSelected.toString()
                                            ? Colors.blue
                                            : ThemeBloc.theme(widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 18,
                                height: 18,
                                child: Center(
                                  child: Text(
                                      state.mapTags.values
                                          .toList()[index][0]
                                          .toString(),
                                      style: TextStyle(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorLight,
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.mapTags.keys.toList()[index] ==
                                          state.tagSelected.toString()
                                      ? Colors.blue
                                      : Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              state.mapTags.values.toList()[index][1] == 0.0
                                  ? Container()
                                  : Text(
                                      humanReadableByteCountSI(state
                                          .mapTags.values
                                          .toList()[index][1]
                                          .toString()),
                                      style: TextStyle(
                                        color: state.mapTags.keys
                                                    .toList()[index] ==
                                                state.tagSelected.toString()
                                            ? Colors.blue
                                            : Colors.blueGrey,
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Radio<String>(
                                value: state.mapTags.keys
                                    .toList()[index]
                                    .toString(),
                                groupValue: state.tagSelected,
                                onChanged: (value) {
                                  filterModel.add(SetFilterSelectedEvent(
                                      filterStatus: FilterValue.none));
                                  filterModel.add(SetTagSelectedEvent(
                                      tagSelected: value.toString()));
                                  filterModel.add(SetTrackerURISelectedEvent(
                                      trackerURISelected: 'null'));
                                },
                                activeColor: Colors.blue,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListTile(
                          minLeadingWidth: 2,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -2),
                          title: Row(
                            children: [
                              Text(l10n.filter_untagged,
                                  style: TextStyle(
                                      color: state.tagSelected
                                                  .toString()
                                                  .split(".")
                                                  .last ==
                                              "Untagged"
                                          ? Colors.blue
                                          : ThemeBloc.theme(widget.themeIndex)
                                              .textTheme
                                              .bodyLarge
                                              ?.color,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 5),
                              Container(
                                width: 18,
                                height: 18,
                                child: Center(
                                  child: Text(
                                      state.mapTags['Untagged'][0].toString(),
                                      style: TextStyle(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorLight,
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.tagSelected
                                              .toString()
                                              .split(".")
                                              .last ==
                                          "Untagged"
                                      ? Colors.blue
                                      : Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          trailing: Radio<String>(
                            value:
                                state.mapTags.keys.toList()[index].toString(),
                            groupValue: state.tagSelected,
                            onChanged: (_) {
                              BlocProvider.of<FilterTorrentBloc>(context,
                                      listen: false)
                                  .add(SetTrackerURISelectedEvent(
                                      trackerURISelected: 'null'));
                              BlocProvider.of<FilterTorrentBloc>(context,
                                      listen: false)
                                  .add(SetTagSelectedEvent(
                                      tagSelected: 'Untagged'));
                              BlocProvider.of<FilterTorrentBloc>(context,
                                      listen: false)
                                  .add(SetFilterSelectedEvent(
                                      filterStatus: FilterValue.none));
                            },
                            activeColor: Colors.blue,
                          ),
                        );
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(l10n.filter_tracker_title,
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text(l10n.filter_all,
                          style: TextStyle(
                              color: state.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              BlocProvider.of<HomeScreenBloc>(context)
                                  .state
                                  .torrentList
                                  .length
                                  .toString(),
                              style: TextStyle(
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.filterStatus.toString().split(".").last ==
                                      "all"
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: state.filterStatus,
                    onChanged: (FilterValue? value) =>
                        onSelectFilterStatus(value!, filterModel),
                    activeColor: Colors.blue,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.maptrackerURIs.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        minLeadingWidth: 2,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -2),
                        title: Row(
                          children: [
                            Text(state.maptrackerURIs.keys.toList()[index],
                                style: TextStyle(
                                    color: state.maptrackerURIs.keys
                                                .toList()[index] ==
                                            state.trackerURISelected.toString()
                                        ? Colors.blue
                                        : ThemeBloc.theme(widget.themeIndex)
                                            .textTheme
                                            .bodyLarge
                                            ?.color,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(width: 5),
                            Container(
                              width: 18,
                              height: 18,
                              child: Center(
                                child: Text(
                                    state.maptrackerURIs.values
                                        .toList()[index][0]
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                            ThemeBloc.theme(widget.themeIndex)
                                                .primaryColorLight,
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    state.maptrackerURIs.keys.toList()[index] ==
                                            state.trackerURISelected.toString()
                                        ? Colors.blue
                                        : Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            state.maptrackerURIs.values.toList()[index][1] ==
                                    0.0
                                ? Container()
                                : Text(
                                    humanReadableByteCountSI(state
                                        .maptrackerURIs.values
                                        .toList()[index][1]
                                        .toString()),
                                    style: TextStyle(
                                      color: state.maptrackerURIs.keys
                                                  .toList()[index] ==
                                              state.trackerURISelected
                                                  .toString()
                                          ? Colors.blue
                                          : Colors.blueGrey,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            Radio<String>(
                              value: state.maptrackerURIs.keys
                                  .toList()[index]
                                  .toString(),
                              groupValue: state.trackerURISelected,
                              onChanged: (value) {
                                filterModel.add(
                                    SetTagSelectedEvent(tagSelected: 'null'));
                                filterModel.add(SetFilterSelectedEvent(
                                    filterStatus: FilterValue.none));
                                filterModel.add(SetTrackerURISelectedEvent(
                                    trackerURISelected: value.toString()));
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  String humanReadableByteCountSI(String bytesStr) {
    // convert bytes to readable format from string
    double bytes = double.parse(bytesStr);
    int unit = 1024;
    if (bytes < unit) return bytes.toString() + " B";
    int exp = (log(bytes) / log(unit)).floor();
    String pre = "kMGTPE"[exp - 1];
    return (bytes / pow(unit, exp)).toStringAsFixed(1) + " " + pre + "B";
  }

  void onSelectFilterStatus(FilterValue? value, FilterTorrentBloc filterModel) {
    filterModel.add(SetTagSelectedEvent(tagSelected: 'null'));
    filterModel.add(SetTrackerURISelectedEvent(trackerURISelected: 'null'));
    filterModel.add(SetFilterSelectedEvent(filterStatus: value!));
  }
}
