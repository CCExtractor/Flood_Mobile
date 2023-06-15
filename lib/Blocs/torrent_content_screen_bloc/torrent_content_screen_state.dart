part of 'torrent_content_screen_bloc.dart';

class TorrentContentScreenState extends Equatable {
  final bool isSelectionMode;
  final List<TorrentContentModel> torrentContentList;
  final List<int> selectedIndexList;

  const TorrentContentScreenState({
    required this.isSelectionMode,
    required this.torrentContentList,
    required this.selectedIndexList,
  });

  @override
  List<Object> get props =>
      [isSelectionMode, torrentContentList, selectedIndexList];

  TorrentContentScreenState copyWith({
    bool? isSelectionMode,
    List<TorrentContentModel>? torrentContentList,
    List<int>? selectedIndexList,
  }) {
    return TorrentContentScreenState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      torrentContentList: torrentContentList ?? this.torrentContentList,
      selectedIndexList: selectedIndexList ?? this.selectedIndexList,
    );
  }
}

class InitialTorrentContentState extends TorrentContentScreenState {
  InitialTorrentContentState()
      : super(
            isSelectionMode: false,
            torrentContentList: [],
            selectedIndexList: []);
}
