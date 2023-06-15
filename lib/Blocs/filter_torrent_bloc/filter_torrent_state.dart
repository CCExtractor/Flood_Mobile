part of 'filter_torrent_bloc.dart';

enum FilterValue {
  all,
  downloading,
  seeding,
  complete,
  stopped,
  active,
  inactive,
  error,
  none,
}

class FilterTorrentState extends Equatable {
  final FilterValue filterStatus;
  final String searchKeyword;
  final List<String> statusList;
  final Map<dynamic, dynamic> mapStatus;
  final String tagSelected;
  final Map<String, dynamic> mapTags;
  final String trackerURISelected;
  final List<dynamic> trackersSizeList;
  final List<dynamic> tagsSizeList;
  final Map<dynamic, dynamic> maptrackerURIs;

  FilterTorrentState({
    this.searchKeyword = '',
    this.filterStatus = FilterValue.all,
    this.statusList = const [],
    this.mapStatus = const {},
    this.tagSelected = '',
    this.mapTags = const {'Untagged': 0},
    this.trackerURISelected = '',
    this.trackersSizeList = const [],
    this.tagsSizeList = const [],
    this.maptrackerURIs = const {},
  });

  FilterTorrentState copyWith({
    String? searchKeyword,
    FilterValue? filterStatus,
    List<String>? statusList,
    Map<dynamic, dynamic>? mapStatus,
    String? tagSelected,
    Map<String, dynamic>? mapTags,
    String? trackerURISelected,
    List<dynamic>? trackersSizeList,
    List<dynamic>? tagsSizeList,
    Map<dynamic, dynamic>? maptrackerURIs,
  }) {
    return FilterTorrentState(
      searchKeyword: searchKeyword ?? this.searchKeyword,
      filterStatus: filterStatus ?? this.filterStatus,
      statusList: statusList ?? this.statusList,
      mapStatus: mapStatus ?? this.mapStatus,
      tagSelected: tagSelected ?? this.tagSelected,
      mapTags: mapTags ?? this.mapTags,
      trackerURISelected: trackerURISelected ?? this.trackerURISelected,
      trackersSizeList: trackersSizeList ?? this.trackersSizeList,
      tagsSizeList: tagsSizeList ?? this.tagsSizeList,
      maptrackerURIs: maptrackerURIs ?? this.maptrackerURIs,
    );
  }

  @override
  List<Object> get props => [
        searchKeyword,
        filterStatus,
        statusList,
        mapStatus,
        tagSelected,
        mapTags,
        trackerURISelected,
        trackersSizeList,
        tagsSizeList,
        maptrackerURIs,
      ];
}
