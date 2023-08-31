import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sort_by_torrent_event.dart';
part 'sort_by_torrent_state.dart';

class SortByTorrentBloc extends Bloc<SortByTorrentEvent, SortByTorrentState> {
  SortByTorrentBloc() : super(SortByTorrentState()) {
    on<SetNameDirectionEvent>((event, emit) {
      _setNameDirectionEvent(event, emit);
    });

    on<SetPercentageDirectionEvent>((event, emit) {
      _setPercentageDirectionEvent(event, emit);
    });

    on<SetDownloadedDirectionEvent>((event, emit) {
      _setDownloadedDirectionEvent(event, emit);
    });

    on<SetDownSpeedDirectionEvent>((event, emit) {
      _setDownSpeedDirectionEvent(event, emit);
    });

    on<SetUploadedDirectionEvent>((event, emit) {
      _setUploadedDirectionEvent(event, emit);
    });

    on<SetUpSpeedDirectionEvent>((event, emit) {
      _setUpSpeedDirectionEvent(event, emit);
    });

    on<SetRatioDirectionEvent>((event, emit) {
      _setRatioDirectionEvent(event, emit);
    });

    on<SetFileSizeDirectionEvent>((event, emit) {
      _setFileSizeDirectionEvent(event, emit);
    });

    on<SetPeersDirectionEvent>((event, emit) {
      _setPeersDirectionEvent(event, emit);
    });

    on<SetSeedsDirectionEvent>((event, emit) {
      _setSeedsDirectionEvent(event, emit);
    });

    on<SetDateAddedDirectionEvent>((event, emit) {
      _setDateAddedDirectionEvent(event, emit);
    });

    on<SetDateCreatedDirectionEvent>((event, emit) {
      _setDateCreatedDirectionEvent(event, emit);
    });
  }

  void _setNameDirectionEvent(
      SetNameDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      nameDirection: event.nameDirection,
      sortByStatus: SortByValue.name,
    ));
  }

  void _setPercentageDirectionEvent(
      SetPercentageDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      percentageDirection: event.percentageDirection,
      sortByStatus: SortByValue.percentage,
    ));
  }

  void _setDownloadedDirectionEvent(
      SetDownloadedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      downloadedDirection: event.downloadedDirection,
      sortByStatus: SortByValue.downloaded,
    ));
  }

  void _setDownSpeedDirectionEvent(
      SetDownSpeedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      downSpeedDirection: event.downSpeedDirection,
      sortByStatus: SortByValue.downSpeed,
    ));
  }

  void _setUploadedDirectionEvent(
      SetUploadedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      uploadedDirection: event.uploadedDirection,
      sortByStatus: SortByValue.uploaded,
    ));
  }

  void _setUpSpeedDirectionEvent(
      SetUpSpeedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      upSpeedDirection: event.upSpeedDirection,
      sortByStatus: SortByValue.upSpeed,
    ));
  }

  void _setRatioDirectionEvent(
      SetRatioDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      ratioDirection: event.ratioDirection,
      sortByStatus: SortByValue.ratio,
    ));
  }

  void _setFileSizeDirectionEvent(
      SetFileSizeDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      fileSizeDirection: event.fileSizeDirection,
      sortByStatus: SortByValue.fileSize,
    ));
  }

  void _setPeersDirectionEvent(
      SetPeersDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
        peersDirection: event.peersDirection, sortByStatus: SortByValue.peers));
  }

  void _setSeedsDirectionEvent(
      SetSeedsDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      seedsDirection: event.seedsDirection,
      sortByStatus: SortByValue.seeds,
    ));
  }

  void _setDateAddedDirectionEvent(
      SetDateAddedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      dateAddedDirection: event.dateAddedDirection,
      sortByStatus: SortByValue.dateAdded,
    ));
  }

  void _setDateCreatedDirectionEvent(
      SetDateCreatedDirectionEvent event, Emitter<SortByTorrentState> emit) {
    emit(state.copyWith(
      dateCreatedDirection: event.dateCreatedDirection,
      sortByStatus: SortByValue.dateCreated,
    ));
  }
}
