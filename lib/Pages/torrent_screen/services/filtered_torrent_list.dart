import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/sort_by_torrent_bloc/sort_by_torrent_bloc.dart';
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
  model.torrentList.forEach(
    (torrent) {
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
      } else if (torrent.tags.isEmpty &&
          filterModel.tagSelected == "Untagged") {
        showTorrentCount++;
      }
    },
  );
  return showTorrentCount;
}

List<TorrentModel> sortTorrents(
    {required List<TorrentModel> torrents,
    required SortByTorrentState sortState}) {
  switch (sortState.sortByStatus) {
    case SortByValue.name:
      torrents.sort((a, b) {
        if (sortState.nameDirection == SortByDirection.ascending) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        } else {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        }
      });
      break;
    case SortByValue.percentage:
      torrents.sort((a, b) {
        if (sortState.percentageDirection == SortByDirection.ascending) {
          return a.percentComplete.compareTo(b.percentComplete);
        } else {
          return b.percentComplete.compareTo(a.percentComplete);
        }
      });
      break;
    case SortByValue.downloaded:
      torrents.sort((a, b) {
        if (sortState.downloadedDirection == SortByDirection.ascending) {
          return a.downTotal.compareTo(b.downTotal);
        } else {
          return b.downTotal.compareTo(a.downTotal);
        }
      });
      break;
    case SortByValue.downSpeed:
      torrents.sort((a, b) {
        if (sortState.downSpeedDirection == SortByDirection.ascending) {
          return a.downRate.compareTo(b.downRate);
        } else {
          return b.downRate.compareTo(a.downRate);
        }
      });
      break;
    case SortByValue.uploaded:
      torrents.sort((a, b) {
        if (sortState.uploadedDirection == SortByDirection.ascending) {
          return a.upTotal.compareTo(b.upTotal);
        } else {
          return b.upTotal.compareTo(a.upTotal);
        }
      });
      break;
    case SortByValue.upSpeed:
      torrents.sort((a, b) {
        if (sortState.upSpeedDirection == SortByDirection.ascending) {
          return a.upRate.compareTo(b.upRate);
        } else {
          return b.upRate.compareTo(a.upRate);
        }
      });
      break;
    case SortByValue.ratio:
      torrents.sort((a, b) {
        if (sortState.ratioDirection == SortByDirection.ascending) {
          return a.ratio.compareTo(b.ratio);
        } else {
          return b.ratio.compareTo(a.ratio);
        }
      });
      break;
    case SortByValue.fileSize:
      torrents.sort((a, b) {
        if (sortState.fileSizeDirection == SortByDirection.ascending) {
          return a.sizeBytes.compareTo(b.sizeBytes);
        } else {
          return b.sizeBytes.compareTo(a.sizeBytes);
        }
      });
      break;
    case SortByValue.peers:
      torrents.sort((a, b) {
        if (sortState.peersDirection == SortByDirection.ascending) {
          return a.peersTotal.compareTo(b.peersTotal);
        } else {
          return b.peersTotal.compareTo(a.peersTotal);
        }
      });
      break;
    case SortByValue.seeds:
      torrents.sort((a, b) {
        if (sortState.seedsDirection == SortByDirection.ascending) {
          return a.seedsTotal.compareTo(b.seedsTotal);
        } else {
          return b.seedsTotal.compareTo(a.seedsTotal);
        }
      });
      break;
    case SortByValue.dateAdded:
      torrents.sort((a, b) {
        if (sortState.dateAddedDirection == SortByDirection.ascending) {
          return a.dateAdded.compareTo(b.dateAdded);
        } else {
          return b.dateAdded.compareTo(a.dateAdded);
        }
      });
      break;
    case SortByValue.dateCreated:
      torrents.sort((a, b) {
        if (sortState.dateCreatedDirection == SortByDirection.ascending) {
          return a.dateCreated.compareTo(b.dateCreated);
        } else {
          return b.dateCreated.compareTo(a.dateCreated);
        }
      });
      break;
    default:
      throw Exception('Unsupported sort criteria');
  }
  return torrents;
}
