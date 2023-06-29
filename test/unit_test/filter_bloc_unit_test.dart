import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('FilterTorrentBloc', () {
    late FilterTorrentBloc filterTorrentBloc;

    setUp(() {
      filterTorrentBloc = FilterTorrentBloc();
    });

    tearDown(() {
      filterTorrentBloc.close();
    });

    test('initial state should be correct', () {
      expect(filterTorrentBloc.state, FilterTorrentState());
    });

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated filterStatus when SetFilterSelectedEvent is added',
      build: () => FilterTorrentBloc(),
      act: (bloc) => bloc
          .add(SetFilterSelectedEvent(filterStatus: FilterValue.downloading)),
      expect: () => [
        FilterTorrentState(
          filterStatus: FilterValue.downloading,
          statusList: [],
          mapStatus: {},
          tagSelected: '',
          mapTags: {'Untagged': 0},
          trackerURISelected: '',
          trackersSizeList: [],
          tagsSizeList: [],
          maptrackerURIs: {},
        ),
      ],
    );
    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated statusList when StatusListChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) =>
          bloc.add(SetStatusListEvent(statusList: ['status1', 'status2'])),
      expect: () => [
        FilterTorrentState(statusList: ['status1', 'status2'])
      ],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated tagSelected when TagSelectedChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) => bloc.add(SetTagSelectedEvent(tagSelected: 'tag1')),
      expect: () => [FilterTorrentState(tagSelected: 'tag1')],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated trackerURISelected when TrackerURISelectedChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) =>
          bloc.add(SetTrackerURISelectedEvent(trackerURISelected: 'tracker1')),
      expect: () => [FilterTorrentState(trackerURISelected: 'tracker1')],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated mapStatus when MapStatusChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) =>
          bloc.add(SetMapStatusEvent(mapStatus: {'status': 'value'})),
      expect: () => [
        FilterTorrentState(mapStatus: {'status': 'value'})
      ],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated mapTags when MapTagsChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) => bloc.add(SetMapTagsEvent(mapTags: {'tag': 'value'})),
      expect: () => [
        FilterTorrentState(mapTags: {'tag': 'value'})
      ],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated trackersSizeList when TrackersSizeListChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) =>
          bloc.add(SetTrackersSizeListEvent(trackersSizeList: [1, 2, 3])),
      expect: () => [
        FilterTorrentState(trackersSizeList: [1, 2, 3])
      ],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated tagsSizeList when TagsSizeListChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) => bloc.add(SetTagsSizeListEvent(tagsSizeList: [4, 5, 6])),
      expect: () => [
        FilterTorrentState(tagsSizeList: [4, 5, 6])
      ],
    );

    blocTest<FilterTorrentBloc, FilterTorrentState>(
      'emits FilterTorrentState with updated maptrackerURIs when MaptrackerURIsChanged event is added',
      build: () => filterTorrentBloc,
      act: (bloc) =>
          bloc.add(SetMapTrackerURIsEvent(maptrackerURIs: {'uri': 'value'})),
      expect: () => [
        FilterTorrentState(maptrackerURIs: {'uri': 'value'})
      ],
    );
  });
}
