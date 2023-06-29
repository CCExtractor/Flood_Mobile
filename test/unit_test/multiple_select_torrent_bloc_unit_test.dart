import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('MultipleSelectTorrentBloc', () {
    late MultipleSelectTorrentBloc bloc;
    late TorrentModel model1;
    late TorrentModel model2;
    late TorrentModel model3;

    setUp(() {
      bloc = MultipleSelectTorrentBloc();
      model1 = TorrentModel(
        bytesDone: 0,
        dateAdded: 0,
        dateCreated: 0,
        directory: '',
        downRate: 0,
        downTotal: 0,
        eta: 0,
        hash: 'hash1',
        isInitialSeeding: false,
        isPrivate: false,
        isSequential: false,
        message: '',
        name: '',
        peersConnected: 0,
        peersTotal: 0,
        percentComplete: 0,
        priority: 0,
        ratio: 0,
        seedsConnected: 0,
        seedsTotal: 0,
        sizeBytes: 0,
        status: [],
        tags: [],
        trackerURIs: [],
        upRate: 0,
        upTotal: 0,
      );
      model2 = TorrentModel(
        bytesDone: 0,
        dateAdded: 0,
        dateCreated: 0,
        directory: '',
        downRate: 0,
        downTotal: 0,
        eta: 0,
        hash: 'hash2',
        isInitialSeeding: false,
        isPrivate: false,
        isSequential: false,
        message: '',
        name: '',
        peersConnected: 0,
        peersTotal: 0,
        percentComplete: 0,
        priority: 0,
        ratio: 0,
        seedsConnected: 0,
        seedsTotal: 0,
        sizeBytes: 0,
        status: [],
        tags: [],
        trackerURIs: [],
        upRate: 0,
        upTotal: 0,
      );
      model3 = TorrentModel(
        bytesDone: 0,
        dateAdded: 0,
        dateCreated: 0,
        directory: '',
        downRate: 0,
        downTotal: 0,
        eta: 0,
        hash: 'hash3',
        isInitialSeeding: false,
        isPrivate: false,
        isSequential: false,
        message: '',
        name: '',
        peersConnected: 0,
        peersTotal: 0,
        percentComplete: 0,
        priority: 0,
        ratio: 0,
        seedsConnected: 0,
        seedsTotal: 0,
        sizeBytes: 0,
        status: [],
        tags: [],
        trackerURIs: [],
        upRate: 0,
        upTotal: 0,
      );
    });
    tearDown(() {
      bloc.close();
    });

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'changeSelectionMode should toggle isSelectionMode',
      build: () => bloc,
      act: (bloc) => bloc.add(ChangeSelectionModeEvent()),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: true,
          selectedTorrentList: [],
          selectedTorrentIndex: [],
        ),
      ],
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'addItemToList should add a model to selectedTorrentList',
      build: () => bloc,
      act: (bloc) => bloc.add(AddItemToListEvent(model: model1)),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [model1],
          selectedTorrentIndex: [],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentList.length, 1);
        expect(bloc.state.selectedTorrentList, [model1]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'removeItemFromList should remove a model from selectedTorrentList',
      build: () => bloc,
      seed: () => MultipleSelectTorrentState(
        isSelectionMode: false,
        selectedTorrentList: [model1, model2, model3],
        selectedTorrentIndex: [],
      ),
      act: (bloc) => bloc.add(RemoveItemFromListEvent(model: model2)),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [model1, model3],
          selectedTorrentIndex: [],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentList.length, 2);
        expect(bloc.state.selectedTorrentList, [model1, model3]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'addAllItemsToList should add multiple models to selectedTorrentList',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(AddAllItemsToListEvent(models: [model1, model2, model3])),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [model1, model2, model3],
          selectedTorrentIndex: [],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentList.length, 3);
        expect(bloc.state.selectedTorrentList, [model1, model2, model3]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'removeAllItemsFromList should clear selectedTorrentList',
      build: () => bloc,
      seed: () => MultipleSelectTorrentState(
        isSelectionMode: false,
        selectedTorrentList: [model1, model2, model3],
        selectedTorrentIndex: [],
      ),
      act: (bloc) => bloc.add(RemoveAllItemsFromListEvent()),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentList.length, 0);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'addIndexToList should add an index to selectedTorrentIndex',
      build: () => bloc,
      act: (bloc) => bloc.add(AddIndexToListEvent(index: [0])),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [0],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentIndex.length, 1);
        expect(bloc.state.selectedTorrentIndex, [0]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'removeIndexFromList should remove an index from selectedTorrentIndex',
      build: () => bloc,
      seed: () => MultipleSelectTorrentState(
        isSelectionMode: false,
        selectedTorrentList: [],
        selectedTorrentIndex: [0, 1, 2, 3],
      ),
      act: (bloc) => bloc.add(RemoveIndexFromListEvent(index: [1, 2])),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [0, 3],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentIndex.length, 2);
        expect(bloc.state.selectedTorrentIndex, [0, 3]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'addAllIndexToList should add multiple indexes to selectedTorrentIndex',
      build: () => bloc,
      act: (bloc) => bloc.add(AddAllIndexToListEvent(index: [0, 1, 2])),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [0, 1, 2],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentIndex.length, 3);
        expect(bloc.state.selectedTorrentIndex, [0, 1, 2]);
      },
    );

    blocTest<MultipleSelectTorrentBloc, MultipleSelectTorrentState>(
      'removeAllIndexFromList should clear selectedTorrentIndex',
      build: () => bloc,
      seed: () => MultipleSelectTorrentState(
        isSelectionMode: false,
        selectedTorrentList: [],
        selectedTorrentIndex: [0, 1, 2],
      ),
      act: (bloc) => bloc.add(RemoveAllIndexFromListEvent()),
      expect: () => [
        MultipleSelectTorrentState(
          isSelectionMode: false,
          selectedTorrentList: [],
          selectedTorrentIndex: [],
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.selectedTorrentIndex.length, 0);
      },
    );
  });
}
