// ignore_for_file: must_be_immutable

part of 'multiple_select_torrent_bloc.dart';

class MultipleSelectTorrentState extends Equatable {
  final bool isSelectionMode;
  List<TorrentModel> selectedTorrentList;
  List<int> selectedTorrentIndex;

  MultipleSelectTorrentState({
    required this.isSelectionMode,
    required this.selectedTorrentList,
    required this.selectedTorrentIndex,
  });

  @override
  List<Object> get props =>
      [isSelectionMode, selectedTorrentList, selectedTorrentIndex];

  MultipleSelectTorrentState copyWith({
    bool? isSelectionMode,
    List<TorrentModel>? selectedTorrentList,
    List<int>? selectedTorrentIndex,
  }) {
    return MultipleSelectTorrentState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedTorrentList: selectedTorrentList ?? this.selectedTorrentList,
      selectedTorrentIndex: selectedTorrentIndex ?? this.selectedTorrentIndex,
    );
  }
}

class InitialMultipleSelectTorrentState extends MultipleSelectTorrentState {
  InitialMultipleSelectTorrentState()
      : super(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [],
        );
  @override
  List<Object> get props =>
      [isSelectionMode, selectedTorrentList, selectedTorrentIndex];
}
