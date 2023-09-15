import 'package:duration/duration.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/focused_menu_items_list.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/torrent_description.dart';
import 'package:flood_mobile/Pages/widgets/delete_torrent_sheet.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class TorrentTile extends StatefulWidget {
  final TorrentModel model;
  final int themeIndex;
  final List<int> indexes;

  TorrentTile(
      {required this.model, required this.themeIndex, required this.indexes});

  @override
  _TorrentTileState createState() => _TorrentTileState();
}

class _TorrentTileState extends State<TorrentTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return BlocBuilder<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      builder: (context, state) {
        return Row(
          children: [
            if (state.isSelectionMode)
              GestureDetector(
                onTap: () {
                  if (state.selectedTorrentList
                      .any((element) => element.hash == widget.model.hash)) {
                    BlocProvider.of<MultipleSelectTorrentBloc>(context)
                        .add(RemoveItemFromListEvent(model: widget.model));
                  } else {
                    BlocProvider.of<MultipleSelectTorrentBloc>(context)
                        .add(AddItemToListEvent(model: widget.model));
                  }
                },
                child: Container(
                  width: 30,
                  height: 90,
                  color: Colors.transparent,
                  padding: EdgeInsets.only(left: 15),
                  child: Center(
                    child: Checkbox(
                      activeColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                      value: state.selectedTorrentList
                          .any((element) => element.hash == widget.model.hash),
                      onChanged: (bool? value) {
                        var selectTorrent =
                            BlocProvider.of<MultipleSelectTorrentBloc>(context);
                        if (value!) {
                          selectTorrent
                              .add(AddItemToListEvent(model: widget.model));
                          selectTorrent
                              .add(AddIndexToListEvent(index: widget.indexes));
                        } else {
                          selectTorrent.add(
                              RemoveItemFromListEvent(model: widget.model));
                          selectTorrent.add(
                              RemoveIndexFromListEvent(index: widget.indexes));
                        }
                      },
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Slidable(
                actionPane: SlidableBehindActionPane(),
                actionExtentRatio: 0.25,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FocusedMenuHolder(
                    key: Key('Long Press Torrent Tile Menu'),
                    menuBoxDecoration: BoxDecoration(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        borderRadius: BorderRadius.circular(50)),
                    menuWidth: MediaQuery.of(context).size.width * 0.5,
                    menuItemExtent: 60,
                    onPressed: () {},
                    menuItems: getFocusedMenuItems(context, widget.indexes,
                        widget.model, widget.themeIndex),
                    child: ExpansionTileCard(
                      key: Key(widget.model.hash),
                      onExpansionChanged: (value) {
                        setState(() {
                          isExpanded = value;
                        });
                      },
                      elevation: 0,
                      expandedColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColor,
                      baseColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColor,
                      expandedTextColor: ThemeBloc.theme(widget.themeIndex)
                          .colorScheme
                          .secondary,
                      title: ListTile(
                        key: Key(widget.model.hash),
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          widget.model.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ThemeBloc.theme(widget.themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (BlocProvider.of<UserInterfaceBloc>(context,
                                      listen: false)
                                  .state
                                  .model
                                  .showProgressBar)
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        key: Key('Linear Progress Indicator'),
                                        padding: EdgeInsets.all(0),
                                        lineHeight: 5.0,
                                        percent: widget.model.percentComplete
                                                .roundToDouble() /
                                            100,
                                        backgroundColor:
                                            ThemeBloc.theme(widget.themeIndex)
                                                .colorScheme
                                                .secondary
                                                .withAlpha(80),
                                        progressColor: (widget
                                                    .model.percentComplete
                                                    .toStringAsFixed(1) ==
                                                '100.0')
                                            ? ThemeBloc.theme(widget.themeIndex)
                                                .primaryColorDark
                                            : Colors.blue,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(widget.model.percentComplete
                                            .toStringAsFixed(1) +
                                        " %"),
                                  ],
                                ),
                              if (BlocProvider.of<UserInterfaceBloc>(context,
                                      listen: false)
                                  .state
                                  .model
                                  .showProgressBar)
                                SizedBox(
                                  height: hp * 0.01,
                                ),
                              Row(
                                children: [
                                  Text(
                                    (widget.model.status
                                            .contains('downloading'))
                                        ? '${context.l10n.filter_status_downloading}  '
                                        : '${context.l10n.filter_status_stopped}  ',
                                    key: Key('status widget'),
                                    style: TextStyle(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      (widget.model.eta.toInt() != -1)
                                          ? ('ETA: ') +
                                              prettyDuration(
                                                  Duration(
                                                    seconds: widget.model.eta
                                                        .toInt(),
                                                  ),
                                                  abbreviated: true)
                                          : 'ETA : ∞',
                                      overflow: TextOverflow.ellipsis,
                                      key: Key('eta widget'),
                                      style: TextStyle(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: hp * 0.002,
                              ),
                              Row(
                                key: Key('download done data widget'),
                                children: [
                                  Text(
                                    filesize(widget.model.bytesDone.toInt()),
                                    style: TextStyle(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                    ),
                                  ),
                                  Text(' / '),
                                  Text(
                                    filesize(widget.model.sizeBytes.toInt()),
                                    style: TextStyle(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (widget.model.status.contains('downloading'))
                              ? GestureDetector(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.stop,
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .primaryColor,
                                    ),
                                  ),
                                  onTap: () {
                                    TorrentApi.stopTorrent(
                                        context: context,
                                        hashes: [widget.model.hash]);
                                  },
                                )
                              : GestureDetector(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .primaryColor,
                                    ),
                                  ),
                                  onTap: () {
                                    TorrentApi.startTorrent(
                                        context: context,
                                        hashes: [widget.model.hash]);
                                  },
                                ),
                          (!isExpanded)
                              ? Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                ),
                        ],
                      ),
                      children: [
                        TorrentDescription(
                            model: widget.model,
                            themeIndex: widget.themeIndex,
                            hp: hp,
                            wp: wp)
                      ],
                    ),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: context.l10n.button_delete,
                    color: Colors.redAccent,
                    icon: Icons.delete,
                    onTap: () {
                      deleteTorrent(
                        context: context,
                        indexes: widget.indexes,
                        torrentModels: [widget.model],
                        themeIndex: widget.themeIndex,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
