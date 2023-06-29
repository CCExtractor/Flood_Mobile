import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Model/torrent_model.dart';

bool isFilteredTorrent(
    TorrentModel torrentModel, FilterTorrentState stateFilterBloc) {
  final searchKeyword = stateFilterBloc.searchKeyword.toLowerCase();
  final filterStatus = stateFilterBloc.filterStatus.toString().split(".").last;
  final trackerURISelected = stateFilterBloc.trackerURISelected;
  final tagSelected = stateFilterBloc.tagSelected;

  final lowerCaseName = torrentModel.name.toLowerCase();
  final containsSearchKeyword = lowerCaseName.contains(searchKeyword);
  final containsFilterStatus = torrentModel.status.contains(filterStatus);
  final containsTrackerURI =
      torrentModel.trackerURIs.contains(trackerURISelected);
  final containsTagSelected = torrentModel.tags.contains(tagSelected);
  final isTagSelectedEmpty = torrentModel.tags.isEmpty;
  final isTagSelectedUntagged = tagSelected == "Untagged";

  if ((containsSearchKeyword && containsFilterStatus) ||
      containsTrackerURI ||
      filterStatus == "all" ||
      (containsTagSelected && !isTagSelectedEmpty) ||
      (isTagSelectedEmpty && isTagSelectedUntagged)) {
    if (containsSearchKeyword) {
      return true;
    }
  }

  return false;
}

int countDisplayTorrent(HomeScreenState model, FilterTorrentState filterModel) {
  int showTorrentCount = 0;
  model.torrentList.forEach((torrent) {
    if (torrent.name
            .toLowerCase()
            .contains(filterModel.searchKeyword.toLowerCase()) &&
        torrent.status
            .contains(filterModel.filterStatus.toString().split(".").last)) {
      showTorrentCount++;
    } else if (torrent.trackerURIs.contains(filterModel.trackerURISelected)) {
      showTorrentCount++;
    } else if (torrent.tags.contains(filterModel.tagSelected)) {
      showTorrentCount++;
    } else if (filterModel.filterStatus.toString().split(".").last == "all") {
      showTorrentCount++;
    } else if (torrent.tags.isEmpty && filterModel.tagSelected == "Untagged") {
      showTorrentCount++;
    }
  });
  return showTorrentCount;
}
