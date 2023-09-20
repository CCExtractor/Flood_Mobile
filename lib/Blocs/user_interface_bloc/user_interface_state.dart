part of 'user_interface_bloc.dart';

class UserInterfaceState extends Equatable {
  final UserInterfaceModel model;

  const UserInterfaceState({
    required this.model,
  });

  factory UserInterfaceState.initial() => UserInterfaceState(
        model: UserInterfaceModel(
          showProgressBar: true,
          showDateAdded: true,
          showDateCreated: true,
          showRatio: false,
          showLocation: true,
          showTags: true,
          showTrackers: false,
          showTrackersMessage: false,
          showDownloadSpeed: false,
          showUploadSpeed: false,
          showPeers: true,
          showSeeds: true,
          showSize: true,
          showType: true,
          showHash: false,
          showDelete: true,
          showCheckHash: true,
          showReannounce: false,
          showSetTags: true,
          showSetTrackers: false,
          showGenerateMagnetLink: false,
          showPriority: false,
          showInitialSeeding: false,
          showSequentialDownload: false,
          showDownloadTorrent: false,
          tagPreferenceButtonValue: TagPreferenceButtonValue.multiSelection,
        ),
      );

  UserInterfaceState copyWith({
    final UserInterfaceModel? model,
  }) {
    return UserInterfaceState(
      model: model ?? this.model,
    );
  }

  @override
  List<Object> get props => [model];
}
