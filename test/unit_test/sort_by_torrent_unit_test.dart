import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:flood_mobile/Blocs/sort_by_torrent_bloc/sort_by_torrent_bloc.dart';

void main() {
  group('SortByTorrentBloc', () {
    late SortByTorrentBloc sortByTorrentBloc;

    setUp(() {
      sortByTorrentBloc = SortByTorrentBloc();
    });

    tearDown(() {
      sortByTorrentBloc.close();
    });

    test('initial state is correct', () {
      expect(sortByTorrentBloc.state, SortByTorrentState());
    });

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetNameDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc
          .add(SetNameDirectionEvent(nameDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          nameDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.name,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetPercentageDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetPercentageDirectionEvent(
          percentageDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          percentageDirection: SortByDirection.descending,
          sortByStatus: SortByValue.percentage,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetDownloadedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetDownloadedDirectionEvent(
          downloadedDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          downloadedDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.downloaded,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetDownSpeedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetDownSpeedDirectionEvent(
          downSpeedDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          downSpeedDirection: SortByDirection.descending,
          sortByStatus: SortByValue.downSpeed,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetUploadedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetUploadedDirectionEvent(
          uploadedDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          uploadedDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.uploaded,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetUpSpeedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetUpSpeedDirectionEvent(
          upSpeedDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          upSpeedDirection: SortByDirection.descending,
          sortByStatus: SortByValue.upSpeed,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetRatioDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(
          SetRatioDirectionEvent(ratioDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          ratioDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.ratio,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetFileSizeDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetFileSizeDirectionEvent(
          fileSizeDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          fileSizeDirection: SortByDirection.descending,
          sortByStatus: SortByValue.fileSize,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetPeersDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(
          SetPeersDirectionEvent(peersDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          peersDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.peers,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetSeedsDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(
          SetSeedsDirectionEvent(seedsDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          seedsDirection: SortByDirection.descending,
          sortByStatus: SortByValue.seeds,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetDateAddedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetDateAddedDirectionEvent(
          dateAddedDirection: SortByDirection.ascending)),
      expect: () => [
        SortByTorrentState(
          dateAddedDirection: SortByDirection.ascending,
          sortByStatus: SortByValue.dateAdded,
        ),
      ],
    );

    blocTest<SortByTorrentBloc, SortByTorrentState>(
      'emits correct state when SetDateCreatedDirectionEvent is added',
      build: () => sortByTorrentBloc,
      act: (bloc) => bloc.add(SetDateCreatedDirectionEvent(
          dateCreatedDirection: SortByDirection.descending)),
      expect: () => [
        SortByTorrentState(
          dateCreatedDirection: SortByDirection.descending,
          sortByStatus: SortByValue.dateCreated,
        ),
      ],
    );
  });
}
