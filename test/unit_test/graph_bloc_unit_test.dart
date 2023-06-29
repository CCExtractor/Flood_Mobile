import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpeedGraphBloc', () {
    late SpeedGraphBloc graphBloc;

    setUp(() {
      graphBloc = SpeedGraphBloc();
    });

    tearDown(() {
      graphBloc.close();
    });

    test('emits correct initial state', () {
      expect(
        graphBloc.state,
        InitialSpeedGraphState(),
      );
    });

    blocTest<SpeedGraphBloc, SpeedGraphState>(
      'toggles show chart status on ChangeChartStatus event',
      build: () => graphBloc,
      act: (bloc) {
        bloc.add(ChangeChartStatusEvent());
      },
      expect: () => [
        predicate<SpeedGraphState>((state) {
          return state.showChart == true;
        }),
      ],
    );

    blocTest<SpeedGraphBloc, SpeedGraphState>(
      'updates graph data correctly on UpdateDataSource event',
      build: () => graphBloc,
      act: (bloc) {
        final homeBloc = HomeScreenBloc();
        homeBloc.state.upSpeed = '100 KB/s';
        homeBloc.state.downSpeed = '200 KB/s';
        bloc.add(UpdateDataSourceEvent(model: homeBloc));
      },
      expect: () => [
        predicate<SpeedGraphState>((state) {
          final uploadGraphData = state.uploadGraphData;
          final downloadGraphData = state.downloadGraphData;
          return uploadGraphData.last.speed == 100.0 &&
              uploadGraphData.last.second == 31 &&
              downloadGraphData.last.speed == 200.0 &&
              downloadGraphData.last.second == 31 &&
              uploadGraphData.length == 30 &&
              uploadGraphData.first.speed == 0.0 &&
              uploadGraphData.first.second == 2 &&
              downloadGraphData.length == 30 &&
              downloadGraphData.first.speed == 0.0 &&
              downloadGraphData.first.second == 2 &&
              state.fakeTime == 32;
        }),
      ],
    );
  });
}
