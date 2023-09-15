import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group(
    'UserInterfaceBloc',
    () {
      late UserInterfaceBloc userInterfaceBloc;

      setUp(() {
        userInterfaceBloc = UserInterfaceBloc();
      });

      tearDown(() {
        userInterfaceBloc.close();
      });

      test('initial state should be UserInterfaceState.initial()', () {
        expect(userInterfaceBloc.state, UserInterfaceState.initial());
      });

      blocTest<UserInterfaceBloc, UserInterfaceState>(
        'should update the user interface model',
        build: () => userInterfaceBloc,
        act: (bloc) => bloc.add(
          UpdateUserInterfaceEvent(
            model: UserInterfaceModel(
                showDateAdded: false,
                showDateCreated: true,
                showRatio: true,
                showLocation: false,
                showTags: true,
                showTrackers: true,
                showTrackersMessage: false,
                showDownloadSpeed: true,
                showUploadSpeed: false,
                showPeers: true,
                showSeeds: false,
                showSize: true,
                showType: false,
                showHash: true,
                showDelete: false,
                showCheckHash: true,
                showReannounce: false,
                showSetTags: true,
                showSetTrackers: false,
                showGenerateMagnetLink: true,
                showPriority: false,
                showInitialSeeding: true,
                showSequentialDownload: false,
                showDownloadTorrent: true,
                showProgressBar: true,
                tagPreferenceButtonValue:
                    TagPreferenceButtonValue.singleSelection),
          ),
        ),
        expect: () => [
          UserInterfaceState(
            model: UserInterfaceModel(
              showDateAdded: false,
              showDateCreated: true,
              showRatio: true,
              showLocation: false,
              showTags: true,
              showTrackers: true,
              showTrackersMessage: false,
              showDownloadSpeed: true,
              showUploadSpeed: false,
              showPeers: true,
              showSeeds: false,
              showSize: true,
              showType: false,
              showHash: true,
              showDelete: false,
              showCheckHash: true,
              showReannounce: false,
              showSetTags: true,
              showSetTrackers: false,
              showGenerateMagnetLink: true,
              showPriority: false,
              showInitialSeeding: true,
              showSequentialDownload: false,
              showDownloadTorrent: true,
              showProgressBar: true,
              tagPreferenceButtonValue:
                  TagPreferenceButtonValue.singleSelection,
            ),
          ),
        ],
      );
    },
  );
}
