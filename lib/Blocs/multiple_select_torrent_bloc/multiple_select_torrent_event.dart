part of 'multiple_select_torrent_bloc.dart';

abstract class MultipleSelectTorrentEvent extends Equatable {
  const MultipleSelectTorrentEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelectionModeEvent extends MultipleSelectTorrentEvent {}

class AddItemToListEvent extends MultipleSelectTorrentEvent {
  final TorrentModel model;

  const AddItemToListEvent({required this.model});

  @override
  List<Object> get props => [model];
}

class RemoveItemFromListEvent extends MultipleSelectTorrentEvent {
  final TorrentModel model;

  const RemoveItemFromListEvent({required this.model});

  @override
  List<Object> get props => [model];
}

class AddAllItemsToListEvent extends MultipleSelectTorrentEvent {
  final List<TorrentModel> models;

  const AddAllItemsToListEvent({required this.models});

  @override
  List<Object> get props => [models];
}

class RemoveAllItemsFromListEvent extends MultipleSelectTorrentEvent {}

class AddIndexToListEvent extends MultipleSelectTorrentEvent {
  final List<int> index;

  const AddIndexToListEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class RemoveIndexFromListEvent extends MultipleSelectTorrentEvent {
  final List<int> index;

  const RemoveIndexFromListEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class AddAllIndexToListEvent extends MultipleSelectTorrentEvent {
  final List<int> index;

  const AddAllIndexToListEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class RemoveAllIndexFromListEvent extends MultipleSelectTorrentEvent {}
