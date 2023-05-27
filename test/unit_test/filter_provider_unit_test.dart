import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Provider/filter_provider.dart';

void main() {
  group('FilterProvider', () {
    late FilterProvider filterProvider;

    setUp(() {
      filterProvider = FilterProvider();
    });

    test('setFilterSelected should update filterStatus', () {
      final newFilterStatus = FilterValue.active;
      expect(filterProvider.filterStatus, equals(FilterValue.all));
      filterProvider.setFilterSelected(newFilterStatus);
      expect(filterProvider.filterStatus, equals(newFilterStatus));
    });

    test('setmapStatus should update mapStatus', () {
      final newMapStatus = {'status1': true, 'status2': false};
      expect(filterProvider.mapStatus, isEmpty);
      filterProvider.setmapStatus(newMapStatus);
      expect(filterProvider.mapStatus, equals(newMapStatus));
    });

    test('setstatusList should update statusList', () {
      final newStatusList = ['status1', 'status2', 'status3'];
      expect(filterProvider.statusList, isEmpty);
      filterProvider.setstatusList(newStatusList);
      expect(filterProvider.statusList, equals(newStatusList));
    });

    test('setTagSelected should update tagSelected and notify listeners', () {
      final newTagSelected = 'New Tag';
      expect(filterProvider.tagSelected, isEmpty);
      filterProvider.setTagSelected(newTagSelected);
      expect(filterProvider.tagSelected, equals(newTagSelected));
    });

    test('setmapTags should update mapTags', () {
      final newMapTags = {'tag1': 0, 'tag2': 1, 'tag3': 2};
      expect(filterProvider.mapTags, equals({'Untagged': 0}));
      filterProvider.setmapTags(newMapTags);
      expect(filterProvider.mapTags, equals(newMapTags));
    });

    test('setTagsSizeList should update tagsSizeList', () {
      final newTagsSizeList = [10, 20, 30];
      expect(filterProvider.tagsSizeList, isEmpty);
      filterProvider.setTagsSizeList(newTagsSizeList);
      expect(filterProvider.tagsSizeList, equals(newTagsSizeList));
    });

    test(
        'settrackerURISelected should update trackerURISelected and notify listeners',
        () {
      final newTrackerURISelected = 'New Tracker URI';
      expect(filterProvider.trackerURISelected, isEmpty);
      filterProvider.settrackerURISelected(newTrackerURISelected);
      expect(filterProvider.trackerURISelected, equals(newTrackerURISelected));
    });

    test('setmaptrackerURIs should update maptrackerURIs', () {
      final newMaptrackerURIs = {'uri1': true, 'uri2': false};
      expect(filterProvider.maptrackerURIs, isEmpty);
      filterProvider.setmaptrackerURIs(newMaptrackerURIs);
      expect(filterProvider.maptrackerURIs, equals(newMaptrackerURIs));
    });

    test('setTrackersSizeList should update trackersSizeList', () {
      final newTrackersSizeList = [100, 200, 300];
      expect(filterProvider.trackersSizeList, isEmpty);
      filterProvider.setTrackersSizeList(newTrackersSizeList);
      expect(filterProvider.trackersSizeList, equals(newTrackersSizeList));
    });
  });
}
