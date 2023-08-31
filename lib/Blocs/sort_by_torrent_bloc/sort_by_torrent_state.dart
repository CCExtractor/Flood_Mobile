part of 'sort_by_torrent_bloc.dart';

enum SortByValue {
  name,
  percentage,
  downloaded,
  downSpeed,
  uploaded,
  upSpeed,
  ratio,
  fileSize,
  peers,
  seeds,
  dateAdded,
  dateCreated,
}

enum SortByDirection {
  ascending,
  descending,
}

class SortByTorrentState extends Equatable {
  final SortByValue sortByStatus;
  final SortByDirection nameDirection;
  final SortByDirection percentageDirection;
  final SortByDirection downloadedDirection;
  final SortByDirection downSpeedDirection;
  final SortByDirection uploadedDirection;
  final SortByDirection upSpeedDirection;
  final SortByDirection ratioDirection;
  final SortByDirection fileSizeDirection;
  final SortByDirection peersDirection;
  final SortByDirection seedsDirection;
  final SortByDirection dateAddedDirection;
  final SortByDirection dateCreatedDirection;

  const SortByTorrentState({
    this.sortByStatus = SortByValue.name,
    this.nameDirection = SortByDirection.ascending,
    this.percentageDirection = SortByDirection.ascending,
    this.downloadedDirection = SortByDirection.ascending,
    this.downSpeedDirection = SortByDirection.ascending,
    this.uploadedDirection = SortByDirection.ascending,
    this.upSpeedDirection = SortByDirection.ascending,
    this.ratioDirection = SortByDirection.ascending,
    this.fileSizeDirection = SortByDirection.ascending,
    this.peersDirection = SortByDirection.ascending,
    this.seedsDirection = SortByDirection.ascending,
    this.dateAddedDirection = SortByDirection.ascending,
    this.dateCreatedDirection = SortByDirection.ascending,
  });

  SortByTorrentState copyWith({
    SortByValue? sortByStatus,
    SortByDirection? nameDirection,
    SortByDirection? percentageDirection,
    SortByDirection? downloadedDirection,
    SortByDirection? downSpeedDirection,
    SortByDirection? uploadedDirection,
    SortByDirection? upSpeedDirection,
    SortByDirection? ratioDirection,
    SortByDirection? fileSizeDirection,
    SortByDirection? peersDirection,
    SortByDirection? seedsDirection,
    SortByDirection? dateAddedDirection,
    SortByDirection? dateCreatedDirection,
  }) {
    return SortByTorrentState(
      sortByStatus: sortByStatus ?? this.sortByStatus,
      nameDirection: nameDirection ?? this.nameDirection,
      percentageDirection: percentageDirection ?? this.percentageDirection,
      downloadedDirection: downloadedDirection ?? this.downloadedDirection,
      downSpeedDirection: downSpeedDirection ?? this.downSpeedDirection,
      uploadedDirection: uploadedDirection ?? this.uploadedDirection,
      upSpeedDirection: upSpeedDirection ?? this.upSpeedDirection,
      ratioDirection: ratioDirection ?? this.ratioDirection,
      fileSizeDirection: fileSizeDirection ?? this.fileSizeDirection,
      peersDirection: peersDirection ?? this.peersDirection,
      seedsDirection: seedsDirection ?? this.seedsDirection,
      dateAddedDirection: dateAddedDirection ?? this.dateAddedDirection,
      dateCreatedDirection: dateCreatedDirection ?? this.dateCreatedDirection,
    );
  }

  @override
  List<Object> get props => [
        sortByStatus,
        nameDirection,
        percentageDirection,
        downloadedDirection,
        downSpeedDirection,
        uploadedDirection,
        upSpeedDirection,
        ratioDirection,
        fileSizeDirection,
        peersDirection,
        seedsDirection,
        dateAddedDirection,
        dateCreatedDirection
      ];
}
