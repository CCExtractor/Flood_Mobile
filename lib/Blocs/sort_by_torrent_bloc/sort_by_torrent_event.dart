part of 'sort_by_torrent_bloc.dart';

abstract class SortByTorrentEvent extends Equatable {
  const SortByTorrentEvent();

  @override
  List<Object?> get props => [];
}

class SetNameDirectionEvent extends SortByTorrentEvent {
  final SortByDirection nameDirection;

  SetNameDirectionEvent({required this.nameDirection});

  @override
  List<Object?> get props => [nameDirection];
}

class SetPercentageDirectionEvent extends SortByTorrentEvent {
  final SortByDirection percentageDirection;

  SetPercentageDirectionEvent({required this.percentageDirection});

  @override
  List<Object?> get props => [percentageDirection];
}

class SetDownloadedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection downloadedDirection;

  SetDownloadedDirectionEvent({required this.downloadedDirection});

  @override
  List<Object?> get props => [downloadedDirection];
}

class SetDownSpeedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection downSpeedDirection;

  SetDownSpeedDirectionEvent({required this.downSpeedDirection});

  @override
  List<Object?> get props => [downSpeedDirection];
}

class SetUploadedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection uploadedDirection;

  SetUploadedDirectionEvent({required this.uploadedDirection});

  @override
  List<Object?> get props => [uploadedDirection];
}

class SetUpSpeedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection upSpeedDirection;

  SetUpSpeedDirectionEvent({required this.upSpeedDirection});

  @override
  List<Object?> get props => [upSpeedDirection];
}

class SetRatioDirectionEvent extends SortByTorrentEvent {
  final SortByDirection ratioDirection;

  SetRatioDirectionEvent({required this.ratioDirection});

  @override
  List<Object?> get props => [ratioDirection];
}

class SetFileSizeDirectionEvent extends SortByTorrentEvent {
  final SortByDirection fileSizeDirection;

  SetFileSizeDirectionEvent({required this.fileSizeDirection});

  @override
  List<Object?> get props => [fileSizeDirection];
}

class SetPeersDirectionEvent extends SortByTorrentEvent {
  final SortByDirection peersDirection;

  SetPeersDirectionEvent({required this.peersDirection});

  @override
  List<Object?> get props => [peersDirection];
}

class SetSeedsDirectionEvent extends SortByTorrentEvent {
  final SortByDirection seedsDirection;

  SetSeedsDirectionEvent({required this.seedsDirection});

  @override
  List<Object?> get props => [seedsDirection];
}

class SetDateAddedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection dateAddedDirection;

  SetDateAddedDirectionEvent({required this.dateAddedDirection});

  @override
  List<Object?> get props => [dateAddedDirection];
}

class SetDateCreatedDirectionEvent extends SortByTorrentEvent {
  final SortByDirection dateCreatedDirection;

  SetDateCreatedDirectionEvent({required this.dateCreatedDirection});

  @override
  List<Object?> get props => [dateCreatedDirection];
}
