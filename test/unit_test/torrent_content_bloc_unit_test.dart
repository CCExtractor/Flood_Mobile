import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

void main() {
  late TorrentContentScreenBloc sut;

  setUp(() {
    sut = TorrentContentScreenBloc();
  });

  tearDown(() => sut.close());
  blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
    'initial values are correct',
    build: () => sut,
    expect: () => [],
  );

  group('SetTorrentContentListEvent', () {
    final newTorrentContentList = [
      TorrentContentModel(
        filename: 'test filename',
        index: 0,
        path: 'test path',
        percentComplete: null,
        priority: 0,
        sizeBytes: 0,
        depth: 0,
        parentPath: ['test parentPath'],
        isMediaFile: true,
      )
    ];

    blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
      'emits updated TorrentContentList state when SetTorrentContentListEvent is added',
      build: () => sut,
      act: (bloc) => bloc.add(SetTorrentContentListEvent(
          newTorrentContentList: newTorrentContentList)),
      expect: () => [
        TorrentContentScreenState(
          isSelectionMode: false,
          torrentContentList: newTorrentContentList,
          selectedIndexList: [],
        ),
      ],
    );
  });

  group('SetSelectionModeEvent', () {
    blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
      'emits updated isSelectionMode state when SetSelectionModeEvent is added',
      build: () => sut,
      act: (bloc) => bloc.add(SetSelectionModeEvent(newIsSelected: true)),
      expect: () => [
        TorrentContentScreenState(
          isSelectionMode: true,
          torrentContentList: [],
          selectedIndexList: [],
        ),
      ],
    );
  });

  group('AddItemToSelectedIndexEvent', () {
    blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
      'emits updated selectedIndexList state when AddItemToSelectedIndexEvent is added',
      build: () => sut,
      act: (bloc) => bloc.add(AddItemToSelectedIndexEvent(index: 1)),
      expect: () => [
        TorrentContentScreenState(
          isSelectionMode: false,
          torrentContentList: [],
          selectedIndexList: [1],
        ),
      ],
    );
  });

  group('RemoveItemFromSelectedListEvent', () {
    setUp(() {
      sut.add(AddItemToSelectedIndexEvent(index: 1));
      sut.add(AddItemToSelectedIndexEvent(index: 2));
    });

    blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
      'emits updated selectedIndexList state when RemoveItemFromSelectedListEvent is added',
      build: () => sut,
      act: (bloc) => bloc.add(RemoveItemFromSelectedListEvent(index: 1)),
      expect: () => [
        TorrentContentScreenState(
          isSelectionMode: false,
          torrentContentList: [],
          selectedIndexList: [2],
        ),
      ],
    );
  });

  group('RemoveAllItemsFromListEvent', () {
    setUp(() {
      sut.add(AddItemToSelectedIndexEvent(index: 1));
      sut.add(AddItemToSelectedIndexEvent(index: 2));
    });

    blocTest<TorrentContentScreenBloc, TorrentContentScreenState>(
      'emits updated selectedIndexList state when RemoveAllItemsFromListEvent is added',
      build: () => sut,
      act: (bloc) => bloc.add(RemoveAllItemsFromListEvent()),
      expect: () => [
        TorrentContentScreenState(
          isSelectionMode: false,
          torrentContentList: [],
          selectedIndexList: [],
        ),
      ],
    );
  });
}
