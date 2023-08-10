import 'package:battery_plus/battery_plus.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/power_management_bloc/power_management_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter bindings

  group('PowerManagementBloc', () {
    late PowerManagementBloc powerManagementBloc;

    setUp(() {
      powerManagementBloc = PowerManagementBloc();
    });

    tearDown(() {
      powerManagementBloc.close();
    });

    test('initial state is correct', () {
      expect(powerManagementBloc.state, PowerManagementState.initial());
    });

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetWifiOnlyDownloadEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) => bloc.add(SetWifiOnlyDownloadEvent(wifiOnlyDownload: true)),
      expect: () => [
        PowerManagementState.initial().copyWith(wifiOnlyDownload: true),
      ],
    );

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetShutDownWhenFinishDownloadEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) => bloc.add(
        SetShutDownWhenFinishDownloadEvent(shutDownWhenFinishDownload: true),
      ),
      expect: () => [
        PowerManagementState.initial().copyWith(
          shutDownWhenFinishDownload: true,
        ),
      ],
    );

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetKeepRunningBackgroundEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) =>
          bloc.add(SetKeepRunningBackgroundEvent(keepRunningBackground: true)),
      expect: () => [
        PowerManagementState.initial().copyWith(keepRunningBackground: true),
      ],
    );

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetDownloadChargingConnectedEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) => bloc.add(SetDownloadChargingConnectedEvent(
        downloadChargingConnected: true,
        currentBatteryState: BatteryState.charging,
      )),
      expect: () => [
        PowerManagementState.initial().copyWith(
          downloadChargingConnected: true,
          currentBatteryState: BatteryState.charging,
        ),
      ],
    );

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetShutDownWifiEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) => bloc.add(SetShutDownWifiEvent(shutDownWifi: true)),
      expect: () => [
        PowerManagementState.initial().copyWith(shutDownWifi: true),
      ],
    );

    blocTest<PowerManagementBloc, PowerManagementState>(
      'emits the correct state when SetBatteryLimitLevelEvent is added',
      build: () => powerManagementBloc,
      act: (bloc) => bloc.add(SetBatteryLimitLevelEvent(batteryLimitLevel: 20)),
      expect: () => [
        PowerManagementState.initial().copyWith(batteryLimitLevel: 20),
      ],
    );
  });
}
