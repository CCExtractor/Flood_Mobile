import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Components/filter_by_status.dart';
import 'package:flood_mobile/Components/bottom_floating_menu_button.dart';
import 'package:flood_mobile/Components/pull_to_reveal.dart';
import 'package:flood_mobile/Components/speed_graph.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/graph_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../Provider/client_provider.dart';
import '../Provider/filter_provider.dart';

class TorrentScreen extends StatefulWidget {
  final int index;

  const TorrentScreen({Key? key, required this.index}) : super(key: key);
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  String keyword = '';

  int countDisplayTorrent(HomeProvider model, String keyword,
      FilterProvider filterModel, int showTorrentCount) {
    model.torrentList.forEach(
      (torrent) {
        if (torrent.name.toLowerCase().contains(keyword.toLowerCase()) &&
                torrent.status.contains(
                    filterModel.filterStatus.toString().split(".").last) ||
            torrent.trackerURIs.contains(filterModel.trackerURISelected) ||
            torrent.tags.contains(filterModel.tagSelected) ||
            filterModel.filterStatus.toString().split(".").last == "all" ||
            torrent.tags.isEmpty && filterModel.tagSelected == "Untagged") {
          if (torrent.name.toLowerCase().contains(keyword.toLowerCase())) {
            showTorrentCount++;
          }
        }
      },
    );
    return showTorrentCount;
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(builder: (context, model, child) {
      EventHandlerApi.filterDataRephrasor(model.torrentList, context);
      return Consumer<ClientSettingsProvider>(
          builder: (context, clientModel, child) {
        return Consumer<FilterProvider>(builder: (context, filterModel, child) {
          int showTorrentCount =
              countDisplayTorrent(model, keyword, filterModel, 0);
          return Consumer<GraphProvider>(builder: ((context, graph, child) {
            return KeyboardDismissOnTap(
              child: Scaffold(
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ThemeProvider.theme(widget.index).primaryColor,
                  child: (model.torrentList.length != 0)
                      ? PullToRevealTopItemList(
                          itemCount: showTorrentCount == 0
                              ? 1
                              : model.torrentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (model.torrentList[index].name
                                        .toLowerCase()
                                        .contains(keyword.toLowerCase()) &&
                                    model.torrentList[index].status.contains(
                                        filterModel.filterStatus
                                            .toString()
                                            .split(".")
                                            .last) ||
                                model.torrentList[index].trackerURIs
                                    .contains(filterModel.trackerURISelected) ||
                                filterModel.filterStatus
                                        .toString()
                                        .split(".")
                                        .last ==
                                    "all" ||
                                model.torrentList[index].tags
                                    .contains(filterModel.tagSelected) ||
                                ((model.torrentList[index].tags.isEmpty &&
                                    filterModel.tagSelected == "Untagged"))) {
                              if (model.torrentList[index].name
                                  .toLowerCase()
                                  .contains(keyword.toLowerCase())) {
                                return TorrentTile(
                                  indexes: [index],
                                  model: model.torrentList[index],
                                  themeIndex: widget.index,
                                );
                              }
                            }
                            return Container(
                              child: showTorrentCount == 0
                                  ? Container(
                                      height: 300,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SText(
                                            text: "No torrents to display.",
                                            index: widget.index,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ThemeProvider.theme(index)
                                                          .primaryColorLight,
                                                  foregroundColor:
                                                      ThemeProvider.theme(index)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.color),
                                              onPressed: () {
                                                setState(() {
                                                  filterModel.setFilterSelected(
                                                      FilterValue.all);
                                                });
                                              },
                                              child: Text("Clear Filter"))
                                        ],
                                      ),
                                    )
                                  : Container(),
                            );
                          },
                          revealableHeight:
                              graph.showChart ? hp / 3 : hp / 4.87,
                          revealableBuilder: (BuildContext context,
                              RevealableToggler opener,
                              RevealableToggler closer,
                              BoxConstraints constraints) {
                            return Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: wp * 0.05,
                                        left: wp * 0.05,
                                        top: hp * 0.01,
                                        bottom: hp * 0.02),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_upward_rounded,
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .primaryColorDark,
                                                size: 24,
                                              ),
                                              Text(
                                                model.upSpeed,
                                                style: TextStyle(
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .primaryColorDark,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: ElevatedButton(
                                            key: Key("Show Chart Button"),
                                            style: ElevatedButton.styleFrom(
                                              alignment: Alignment.center,
                                              backgroundColor: graph.showChart
                                                  ? Color(0xff39C481)
                                                  : Color(0xff39C481)
                                                      .withAlpha(70),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: AnimatedSwitcher(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  transitionBuilder: (child,
                                                          anim) =>
                                                      RotationTransition(
                                                        turns: child.key ==
                                                                ValueKey(
                                                                    'icon1')
                                                            ? Tween<double>(
                                                                    begin: 1,
                                                                    end: 0.75)
                                                                .animate(anim)
                                                            : Tween<double>(
                                                                    begin: 0.75,
                                                                    end: 1)
                                                                .animate(anim),
                                                        child: ScaleTransition(
                                                            scale: anim,
                                                            child: child),
                                                      ),
                                                  child: graph.showChart == true
                                                      ? Icon(
                                                          Icons.close,
                                                          key: const ValueKey(
                                                              'icon1'),
                                                          size: 30,
                                                        )
                                                      : Image.asset(
                                                          'assets/images/line-chart.png',
                                                          height: 23,
                                                          width: 23,
                                                        )),
                                            ),
                                            onPressed: (() {
                                              graph.changChartStatus();
                                            }),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward_rounded,
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .colorScheme
                                                    .secondary,
                                                size: 23,
                                              ),
                                              Text(
                                                model.downSpeed,
                                                style: TextStyle(
                                                  color: ThemeProvider.theme(
                                                          widget.index)
                                                      .colorScheme
                                                      .secondary,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (graph.showChart)
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: wp * 0.01,
                                          left: wp * 0.01,
                                          bottom: hp * 0.025),
                                      width: wp,
                                      child: SpeedGraph(
                                        model: model,
                                        index: widget.index,
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.only(
                                        left: wp * 0.05, right: wp * 0.05),
                                    child: TextField(
                                      key: Key("Search Torrent TextField"),
                                      onChanged: (value) {
                                        setState(() {
                                          keyword = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        hintText: 'Search Torrent',
                                        suffixIcon: Padding(
                                          key: Key("Filter Torrent ActionChip"),
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: ActionChip(
                                            padding: EdgeInsets.all(0),
                                            avatar: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    color: Colors.green,
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  child: Icon(
                                                    Icons.filter_list_alt,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                )),
                                            label: Text(
                                              filterModel
                                                              .tagSelected ==
                                                          'all' ||
                                                      filterModel
                                                              .tagSelected ==
                                                          'null' ||
                                                      filterModel
                                                              .tagSelected ==
                                                          ''
                                                  ? filterModel.trackerURISelected ==
                                                              'all' ||
                                                          filterModel
                                                                  .trackerURISelected ==
                                                              'null' ||
                                                          filterModel
                                                                  .trackerURISelected ==
                                                              ''
                                                      ? '${filterModel.filterStatus.toString().split(".").last}'
                                                      : filterModel
                                                                  .trackerURISelected
                                                                  .length >
                                                              12
                                                          ? filterModel
                                                                  .trackerURISelected
                                                                  .substring(
                                                                      0, 12) +
                                                              '...'
                                                          : filterModel
                                                              .trackerURISelected
                                                  : filterModel.tagSelected
                                                              .length >
                                                          12
                                                      ? filterModel.tagSelected
                                                              .substring(
                                                                  0, 12) +
                                                          '...'
                                                      : filterModel.tagSelected,
                                              style: TextStyle(
                                                color: ThemeProvider.theme(
                                                        widget.index)
                                                    .primaryColorDark,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                isScrollControlled: true,
                                                context: context,
                                                backgroundColor:
                                                    ThemeProvider.theme(
                                                            widget.index)
                                                        .colorScheme
                                                        .background,
                                                builder: (context) {
                                                  return FilterByStatus(
                                                      key: Key(
                                                          "Filter By Status Bottom Sheet"),
                                                      index: widget.index);
                                                },
                                              );
                                            },
                                            backgroundColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey,
                                                )),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'assets/images/empty_dark.svg',
                            width: 120,
                            height: 120,
                          ),
                        ),
                ),
                floatingActionButton: BottomFloatingMenuButton(
                    key: Key('Floating Action Button'), index: widget.index),
              ),
            );
          }));
        });
      });
    });
  }
}
