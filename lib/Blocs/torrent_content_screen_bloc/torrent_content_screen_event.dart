part of 'torrent_content_screen_bloc.dart';

abstract class TorrentContentScreenEvent extends Equatable {
  const TorrentContentScreenEvent();

  @override
  List<Object> get props => [];
}

class SetSelectionModeEvent extends TorrentContentScreenEvent {
  final bool newIsSelected;

  const SetSelectionModeEvent({required this.newIsSelected});

  @override
  List<Object> get props => [newIsSelected];
}

class SetTorrentContentListEvent extends TorrentContentScreenEvent {
  final List<TorrentContentModel> newTorrentContentList;

  const SetTorrentContentListEvent({required this.newTorrentContentList});

  @override
  List<Object> get props => [newTorrentContentList];
}

class AddItemToSelectedIndexEvent extends TorrentContentScreenEvent {
  final int index;

  const AddItemToSelectedIndexEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class RemoveItemFromSelectedListEvent extends TorrentContentScreenEvent {
  final int index;

  const RemoveItemFromSelectedListEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class RemoveAllItemsFromListEvent extends TorrentContentScreenEvent {}
