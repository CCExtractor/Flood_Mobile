import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/torrent_model.dart';

part 'multiple_select_torrent_event.dart';
part 'multiple_select_torrent_state.dart';

class MultipleSelectTorrentBloc
    extends Bloc<MultipleSelectTorrentEvent, MultipleSelectTorrentState> {
  MultipleSelectTorrentBloc() : super(InitialMultipleSelectTorrentState()) {
    on<ChangeSelectionModeEvent>(_changeSelectionMode);
    on<AddItemToListEvent>(_addItemToList);
    on<RemoveItemFromListEvent>(_removeItemFromList);
    on<AddAllItemsToListEvent>(_addAllItemsToList);
    on<RemoveAllItemsFromListEvent>(_removeAllItemsFromList);
    on<AddIndexToListEvent>(_addIndexToList);
    on<RemoveIndexFromListEvent>(_removeIndexFromList);
    on<AddAllIndexToListEvent>(_addAllIndexToList);
    on<RemoveAllIndexFromListEvent>(_removeAllIndexFromList);
  }

  // Handle the ChangeSelectionMode event
  void _changeSelectionMode(ChangeSelectionModeEvent event,
      Emitter<MultipleSelectTorrentState> emit) {
    emit(state.copyWith(isSelectionMode: !state.isSelectionMode));
  }

  // Handle the AddItemToList event
  void _addItemToList(
      AddItemToListEvent event, Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<TorrentModel>.from(state.selectedTorrentList)
      ..add(event.model);
    emit(state.copyWith(selectedTorrentList: updatedList));
  }

  // Handle the RemoveItemFromList event
  void _removeItemFromList(
      RemoveItemFromListEvent event, Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<TorrentModel>.from(state.selectedTorrentList)
      ..removeWhere((element) => element.hash == event.model.hash);
    emit(state.copyWith(selectedTorrentList: updatedList));
  }

  // Handle the AddAllItemsToList event
  void _addAllItemsToList(
      AddAllItemsToListEvent event, Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<TorrentModel>.from(state.selectedTorrentList)
      ..addAll(event.models);
    emit(state.copyWith(selectedTorrentList: updatedList));
  }

  // Handle the RemoveAllItemsFromList event
  void _removeAllItemsFromList(RemoveAllItemsFromListEvent event,
      Emitter<MultipleSelectTorrentState> emit) {
    emit(state.copyWith(selectedTorrentList: []));
  }

  // Handle the AddIndexToList event
  void _addIndexToList(
      AddIndexToListEvent event, Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<int>.from(state.selectedTorrentIndex)
      ..addAll(event.index
          .where((element) => !state.selectedTorrentIndex.contains(element)));
    emit(state.copyWith(selectedTorrentIndex: updatedList));
  }

  // Handle the RemoveIndexFromList event
  void _removeIndexFromList(RemoveIndexFromListEvent event,
      Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<int>.from(state.selectedTorrentIndex)
      ..removeWhere((element) => event.index.contains(element));
    emit(state.copyWith(selectedTorrentIndex: updatedList));
  }

  // Handle the AddAllIndexToList event
  void _addAllIndexToList(
      AddAllIndexToListEvent event, Emitter<MultipleSelectTorrentState> emit) {
    final updatedList = List<int>.from(state.selectedTorrentIndex)
      ..addAll(event.index);
    emit(state.copyWith(selectedTorrentIndex: updatedList));
  }

  // Handle the RemoveAllIndexFromList event
  void _removeAllIndexFromList(RemoveAllIndexFromListEvent event,
      Emitter<MultipleSelectTorrentState> emit) {
    emit(state.copyWith(selectedTorrentIndex: []));
  }
}
