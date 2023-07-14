import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/torrent_screen/widgets/sort_by_bottom_sheet.dart';

class SearchTorrentTextField extends StatefulWidget {
  final int themeIndex;
  final FilterTorrentState stateFilterBlocState;
  SearchTorrentTextField({
    Key? key,
    required this.themeIndex,
    required this.stateFilterBlocState,
  }) : super(key: key);

  @override
  State<SearchTorrentTextField> createState() => _SearchTorrentTextFieldState();
}

class _SearchTorrentTextFieldState extends State<SearchTorrentTextField> {
  @override
  Widget build(BuildContext context) {
    double wp = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: 100,
        padding: EdgeInsets.only(left: wp * 0.05, right: wp * 0.05),
        child: TextField(
          key: Key("Search Torrent TextField"),
          onChanged: (value) {
            BlocProvider.of<FilterTorrentBloc>(context)
                .add(SetSearchKeywordEvent(
              searchKeyword: value,
            ));
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            hintText: context.l10n.search_torrent_text,
            prefixIcon: IconButton(
              icon: Icon(
                FontAwesomeIcons.sortAlphaUp,
                color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                size: 22,
              ),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  backgroundColor:
                      ThemeBloc.theme(widget.themeIndex).colorScheme.background,
                  builder: (context) {
                    return SortByBottomSheet(
                      key: Key("Sort By Status Bottom Sheet"),
                      themeIndex: widget.themeIndex,
                    );
                  },
                );
              },
            ),
            suffixIcon: Padding(
              key: Key("Filter Torrent ActionChip"),
              padding: const EdgeInsets.only(right: 5),
              child: ActionChip(
                padding: EdgeInsets.all(0),
                avatar: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
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
                  returnFilterText(widget.stateFilterBlocState),
                  style: TextStyle(
                    color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: ThemeBloc.theme(widget.themeIndex)
                        .colorScheme
                        .background,
                    builder: (context) {
                      return FilterByStatus(
                        key: Key("Filter By Status Bottom Sheet"),
                        themeIndex: widget.themeIndex,
                      );
                    },
                  );
                },
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      width: 1,
                      color: Colors.blueGrey,
                    )),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

String returnFilterText(FilterTorrentState stateFilterBlocState) {
  final tagSelected = stateFilterBlocState.tagSelected;
  final trackerURISelected = stateFilterBlocState.trackerURISelected;
  final filterStatus =
      stateFilterBlocState.filterStatus.toString().split(".").last;

  if (tagSelected == 'all' || tagSelected == 'null' || tagSelected == '') {
    if (trackerURISelected == 'all' ||
        trackerURISelected == 'null' ||
        trackerURISelected == '') {
      return filterStatus;
    } else {
      if (trackerURISelected.length > 12) {
        return trackerURISelected.substring(0, 12) + '...';
      } else {
        return trackerURISelected;
      }
    }
  } else {
    if (tagSelected.length > 12) {
      return tagSelected.substring(0, 12) + '...';
    } else {
      return tagSelected;
    }
  }
}
