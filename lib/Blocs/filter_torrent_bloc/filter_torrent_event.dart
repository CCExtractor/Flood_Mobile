part of 'filter_torrent_bloc.dart';

abstract class FilterTorrentEvent extends Equatable {
  const FilterTorrentEvent();

  @override
  List<Object?> get props => [];
}

class SetSearchKeywordEvent extends FilterTorrentEvent {
  final String searchKeyword;

  const SetSearchKeywordEvent({required this.searchKeyword});

  @override
  List<Object> get props => [searchKeyword];
}

class SetFilterSelectedEvent extends FilterTorrentEvent {
  final FilterValue filterStatus;

  SetFilterSelectedEvent({required this.filterStatus});

  @override
  List<Object?> get props => [filterStatus];
}

class SetMapStatusEvent extends FilterTorrentEvent {
  final Map<dynamic, dynamic> mapStatus;

  const SetMapStatusEvent({required this.mapStatus});

  @override
  List<Object> get props => [mapStatus];
}

class SetStatusListEvent extends FilterTorrentEvent {
  final List<String> statusList;

  const SetStatusListEvent({required this.statusList});

  @override
  List<Object> get props => [statusList];
}

class SetTagSelectedEvent extends FilterTorrentEvent {
  final String tagSelected;

  const SetTagSelectedEvent({required this.tagSelected});

  @override
  List<Object> get props => [tagSelected];
}

class SetMapTagsEvent extends FilterTorrentEvent {
  final Map<String, dynamic> mapTags;

  const SetMapTagsEvent({required this.mapTags});

  @override
  List<Object> get props => [mapTags];
}

class SetTagsSizeListEvent extends FilterTorrentEvent {
  final List<dynamic> tagsSizeList;

  const SetTagsSizeListEvent({required this.tagsSizeList});

  @override
  List<Object> get props => [tagsSizeList];
}

class SetTrackerURISelectedEvent extends FilterTorrentEvent {
  final String trackerURISelected;

  const SetTrackerURISelectedEvent({required this.trackerURISelected});

  @override
  List<Object> get props => [trackerURISelected];
}

class SetMapTrackerURIsEvent extends FilterTorrentEvent {
  final Map<dynamic, dynamic> maptrackerURIs;

  const SetMapTrackerURIsEvent({required this.maptrackerURIs});

  @override
  List<Object> get props => [maptrackerURIs];
}

class SetTrackersSizeListEvent extends FilterTorrentEvent {
  final List<dynamic> trackersSizeList;

  const SetTrackersSizeListEvent({required this.trackersSizeList});

  @override
  List<Object> get props => [trackersSizeList];
}
