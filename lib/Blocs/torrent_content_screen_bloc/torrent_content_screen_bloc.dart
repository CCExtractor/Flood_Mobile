import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/torrent_content_model.dart';

part 'torrent_content_screen_event.dart';
part 'torrent_content_screen_state.dart';

class TorrentContentScreenBloc
    extends Bloc<TorrentContentScreenEvent, TorrentContentScreenState> {
  TorrentContentScreenBloc() : super(InitialTorrentContentState()) {
    on<SetSelectionModeEvent>(_setSelectionMode);
    on<SetTorrentContentListEvent>(_setTorrentContentList);
    on<AddItemToSelectedIndexEvent>(_addItemToSelectedIndex);
    on<RemoveItemFromSelectedListEvent>(_removeItemFromSelectedList);
    on<RemoveAllItemsFromListEvent>(_removeAllItemsFromList);
  }

  // Handle the SetSelectionMode event
  void _setSelectionMode(
    SetSelectionModeEvent event,
    Emitter<TorrentContentScreenState> emit,
  ) {
    emit(state.copyWith(isSelectionMode: event.newIsSelected));
  }

  // Handle the SetTorrentContentList event
  void _setTorrentContentList(
    SetTorrentContentListEvent event,
    Emitter<TorrentContentScreenState> emit,
  ) {
    emit(state.copyWith(torrentContentList: event.newTorrentContentList));
  }

  // Handle the AddItemToSelectedIndex event
  void _addItemToSelectedIndex(
    AddItemToSelectedIndexEvent event,
    Emitter<TorrentContentScreenState> emit,
  ) {
    final updatedList = List<int>.from(state.selectedIndexList)
      ..add(event.index);
    emit(state.copyWith(selectedIndexList: updatedList));
  }

  // Handle the RemoveItemFromSelectedList event
  void _removeItemFromSelectedList(
    RemoveItemFromSelectedListEvent event,
    Emitter<TorrentContentScreenState> emit,
  ) {
    final updatedList = List<int>.from(state.selectedIndexList)
      ..remove(event.index);
    emit(state.copyWith(selectedIndexList: updatedList));
  }

  // Handle the RemoveAllItemsFromList event
  void _removeAllItemsFromList(
    RemoveAllItemsFromListEvent event,
    Emitter<TorrentContentScreenState> emit,
  ) {
    emit(state.copyWith(selectedIndexList: []));
  }
}
