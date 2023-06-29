import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_torrent_event.dart';
part 'filter_torrent_state.dart';

class FilterTorrentBloc extends Bloc<FilterTorrentEvent, FilterTorrentState> {
  FilterTorrentBloc() : super(FilterTorrentState()) {
    on<SetSearchKeywordEvent>((event, emit) {
      _setSearchKeyword(event, emit);
    });

    on<SetFilterSelectedEvent>((event, emit) {
      _setFilterSelected(event, emit);
    });

    on<SetMapStatusEvent>((event, emit) {
      _setMapStatus(event, emit);
    });

    on<SetStatusListEvent>((event, emit) {
      _setStatusList(event, emit);
    });

    on<SetTagSelectedEvent>((event, emit) {
      _setTagSelected(event, emit);
    });

    on<SetMapTagsEvent>((event, emit) {
      _setMapTags(event, emit);
    });

    on<SetTagsSizeListEvent>((event, emit) {
      _setTagsSizeList(event, emit);
    });

    on<SetTrackerURISelectedEvent>((event, emit) {
      _setTrackerURISelected(event, emit);
    });

    on<SetMapTrackerURIsEvent>((event, emit) {
      _setMapTrackerURIs(event, emit);
    });

    on<SetTrackersSizeListEvent>((event, emit) {
      _setTrackersSizeList(event, emit);
    });
  }

  // Set the filter status
  void _setFilterSelected(
      SetFilterSelectedEvent event, Emitter<FilterTorrentState> emit) {
    // state.filterStatus = event.filterStatus;
    emit(state.copyWith(filterStatus: event.filterStatus));
  }

  // Set the map status
  void _setMapStatus(
      SetMapStatusEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(mapStatus: event.mapStatus));
  }

  // Set the status list
  void _setStatusList(
      SetStatusListEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(statusList: event.statusList));
  }

  // Set the selected tag
  void _setTagSelected(
      SetTagSelectedEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(tagSelected: event.tagSelected));
  }

  // Set the map of tags
  void _setMapTags(SetMapTagsEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(mapTags: event.mapTags));
  }

  // Set the list of tags sizes
  void _setTagsSizeList(
      SetTagsSizeListEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(tagsSizeList: event.tagsSizeList));
  }

  // Set the selected tracker URI
  void _setTrackerURISelected(
      SetTrackerURISelectedEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(trackerURISelected: event.trackerURISelected));
  }

  // Set the map of tracker URIs
  void _setMapTrackerURIs(
      SetMapTrackerURIsEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(maptrackerURIs: event.maptrackerURIs));
  }

  // Set the list of tracker URIs sizes
  void _setTrackersSizeList(
      SetTrackersSizeListEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(trackersSizeList: event.trackersSizeList));
  }

  void _setSearchKeyword(
      SetSearchKeywordEvent event, Emitter<FilterTorrentState> emit) {
    emit(state.copyWith(searchKeyword: event.searchKeyword));
  }
}
