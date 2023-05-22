import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/torrent_model.dart';
import 'package:flood_mobile/Provider/multiple_select_torrent_provider.dart';

void main() {
  group('MultipleSelectTorrentProvider', () {
    late MultipleSelectTorrentProvider provider;
    late TorrentModel model1;
    late TorrentModel model2;
    late TorrentModel model3;

    setUp(() {
      provider = MultipleSelectTorrentProvider();
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

    test('changeSelectionMode should toggle isSelectionMode', () {
      expect(provider.isSelectionMode, false);
      provider.changeSelectionMode();
      expect(provider.isSelectionMode, true);
      provider.changeSelectionMode();
      expect(provider.isSelectionMode, false);
    });

    test('addItemToList should add a model to selectedTorrentList', () {
      expect(provider.selectedTorrentList.length, 0);
      provider.addItemToList(model1);
      expect(provider.selectedTorrentList.length, 1);
      expect(provider.selectedTorrentList, [model1]);
    });

    test('removeItemFromList should remove a model from selectedTorrentList',
        () {
      provider.selectedTorrentList = [model1, model2, model3];
      provider.removeItemFromList(model2);
      expect(provider.selectedTorrentList.length, 2);
      expect(provider.selectedTorrentList, [model1, model3]);
    });

    test('addAllItemsToList should add multiple models to selectedTorrentList',
        () {
      expect(provider.selectedTorrentList.length, 0);
      provider.addAllItemsToList([model1, model2, model3]);
      expect(provider.selectedTorrentList.length, 3);
      expect(provider.selectedTorrentList, [model1, model2, model3]);
    });

    test('removeAllItemsFromList should clear selectedTorrentList', () {
      provider.selectedTorrentList = [model1, model2, model3];
      expect(provider.selectedTorrentList.length, 3);
      provider.removeAllItemsFromList();
      expect(provider.selectedTorrentList.length, 0);
    });

    test('addIndexToList should add an index to selectedTorrentIndex', () {
      expect(provider.selectedTorrentIndex.length, 0);
      provider.addIndexToList([0]);
      expect(provider.selectedTorrentIndex.length, 1);
      expect(provider.selectedTorrentIndex, [0]);
    });

    test('removeIndexFromList should remove an index from selectedTorrentIndex',
        () {
      provider.selectedTorrentIndex = [0, 1, 2, 3];
      provider.removeIndexFromList([1, 2]);
      expect(provider.selectedTorrentIndex.length, 2);
      expect(provider.selectedTorrentIndex, [0, 3]);
    });

    test(
        'addAllIndexToList should add multiple indexes to selectedTorrentIndex',
        () {
      expect(provider.selectedTorrentIndex.length, 0);
      provider.addAllIndexToList([0, 1, 2]);
      expect(provider.selectedTorrentIndex.length, 3);
      expect(provider.selectedTorrentIndex, [0, 1, 2]);
    });

    test('removeAllIndexFromList should clear selectedTorrentIndex', () {
      provider.selectedTorrentIndex = [0, 1, 2];
      expect(provider.selectedTorrentIndex.length, 3);
      provider.removeAllIndexFromList();
      expect(provider.selectedTorrentIndex.length, 0);
    });
  });
}
