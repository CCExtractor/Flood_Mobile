import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:flood_mobile/Provider/torrent_content_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TorrentContentProvider sut;

  setUp(() {
    sut = TorrentContentProvider();
  });

  test(
    "initial values are correct",
    () {
      expect(sut.torrentContentList, []);
      expect(sut.isSelectionMode, false);
      expect(sut.selectedIndexList, []);
    },
  );

  group('setTorrentContentList', () {
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

    test(
      "tests setTorrentContentList working",
      () async {
        expect(sut.torrentContentList.isEmpty, true);
        sut.setTorrentContentList(newTorrentContentList);
        expect(sut.torrentContentList.isEmpty, false);
        expect(sut.torrentContentList[0].filename, 'test filename');
      },
    );

    test(
      "tests setSelectionMode working",
      () async {
        expect(sut.isSelectionMode, false);
        sut.setSelectionMode(newIsSelected: true);
        expect(sut.isSelectionMode, true);
      },
    );

    test(
      "tests addItemToSelectedIndex working",
      () async {
        expect(sut.selectedIndexList.length, 0);
        sut.addItemToSelectedIndex(1);
        expect(sut.selectedIndexList.length, 1);
      },
    );

    test(
      "tests removeItemFromSelectedList working",
      () async {
        expect(sut.selectedIndexList.length, 0);
        sut.addItemToSelectedIndex(1);
        sut.addItemToSelectedIndex(2);
        sut.removeItemFromSelectedList(1);
        expect(sut.selectedIndexList, [2]);
      },
    );

    test(
      "tests removeAllItemsFromList working",
      () async {
        sut.addItemToSelectedIndex(1);
        sut.addItemToSelectedIndex(2);
        expect(sut.selectedIndexList.length, 2);
        sut.removeAllItemsFromList();
        expect(sut.selectedIndexList.length, 0);
      },
    );
  });
}
