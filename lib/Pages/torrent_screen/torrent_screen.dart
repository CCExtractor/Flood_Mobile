import 'package:flood_mobile/Api/event_handler_api.dart';
import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flood_mobile/Pages/torrent_screen/services/filtered_torrent_list.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/bottom_floating_menu_button.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/pull_to_reveal.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/search_torrent_textfield_widget.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/show_chart_button.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/speed_graph.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/speed_text_icon_widget.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/torrent_tile.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

class TorrentScreen extends StatefulWidget {
  final int themeIndex;

  const TorrentScreen({Key? key, required this.themeIndex}) : super(key: key);
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        EventHandlerApi.filterDataRephrasor(state.torrentList, context);
        return BlocBuilder<FilterTorrentBloc, FilterTorrentState>(
          builder: (context, stateFilterBloc) {
            int showTorrentCount = countDisplayTorrent(state, stateFilterBloc);
            return KeyboardDismissOnTap(
              child: Scaffold(
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ThemeBloc.theme(widget.themeIndex).primaryColor,
                  child: (state.torrentList.length != 0)
                      ? BlocBuilder<SpeedGraphBloc, SpeedGraphState>(
                          builder: (context, graphSstate) {
                            return PullToRevealTopItemList(
                              itemCount: showTorrentCount == 0
                                  ? 1
                                  : state.torrentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (isFilteredTorrent(
                                    state.torrentList[index], stateFilterBloc))
                                  return TorrentTile(
                                    indexes: [index],
                                    model: state.torrentList[index],
                                    themeIndex: widget.themeIndex,
                                  );
                                return showTorrentCount == 0
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
                                              themeIndex: widget.themeIndex,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        ThemeBloc.theme(widget
                                                                .themeIndex)
                                                            .primaryColorLight,
                                                    foregroundColor:
                                                        ThemeBloc.theme(widget
                                                                .themeIndex)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.color),
                                                onPressed: () {
                                                  setState(() {
                                                    BlocProvider.of<
                                                                FilterTorrentBloc>(
                                                            context)
                                                        .add(
                                                      SetFilterSelectedEvent(
                                                        filterStatus:
                                                            FilterValue.all,
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: Text("Clear Filter"))
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                              revealableHeight:
                                  graphSstate.showChart ? hp / 3 : hp / 4.87,
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
                                            SpeedTextIconWidget(
                                              themeIndex: widget.themeIndex,
                                              speedIcon:
                                                  Icons.arrow_upward_rounded,
                                              speedText: state.upSpeed,
                                              speedColor: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .primaryColorDark,
                                            ),
                                            ShowChartButton(),
                                            SpeedTextIconWidget(
                                              themeIndex: widget.themeIndex,
                                              speedIcon:
                                                  Icons.arrow_downward_rounded,
                                              speedText: state.downSpeed,
                                              speedColor: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (graphSstate.showChart)
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: wp * 0.01,
                                              left: wp * 0.01,
                                              bottom: hp * 0.025),
                                          width: double.infinity,
                                          child: SpeedGraph(
                                            model:
                                                BlocProvider.of<HomeScreenBloc>(
                                                    context),
                                            themeIndex: widget.themeIndex,
                                          ),
                                        ),
                                      ),
                                    SearchTorrentTextField(
                                        themeIndex: widget.themeIndex,
                                        stateFilterBlocState: stateFilterBloc)
                                  ],
                                );
                              },
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
                    key: Key('Floating Action Button'),
                    themeIndex: widget.themeIndex),
              ),
            );
          },
        );
      },
    );
  }
}
