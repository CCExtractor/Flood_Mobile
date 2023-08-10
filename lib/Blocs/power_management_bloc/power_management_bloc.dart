import 'package:battery_plus/battery_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';

part 'power_management_event.dart';
part 'power_management_state.dart';

class PowerManagementBloc
    extends Bloc<PowerManagementEvent, PowerManagementState> {
  PowerManagementBloc() : super(PowerManagementState.initial()) {
    on<PowerManagementEvent>((event, emit) {});

    on<SetWifiOnlyDownloadEvent>(
      (event, emit) => _setWifiOnlyDownloadEvent(event, emit),
    );

    on<SetShutDownWhenFinishDownloadEvent>(
      (event, emit) => _setShutDownWhenFinishDownloadEvent(event, emit),
    );

    on<SetKeepRunningBackgroundEvent>(
      (event, emit) => _setKeepRunningBackgroundEvent(event, emit),
    );

    on<SetKeepCpuAwakeEvent>(
      (event, emit) => _setKeepCpuAwakeEvent(event, emit),
    );

    on<SetDownloadChargingConnectedEvent>(
      (event, emit) => _setDownloadChargingConnectedEvent(event, emit),
    );

    on<SetShutDownWifiEvent>(
      (event, emit) => _setShutDownWifiEvent(event, emit),
    );

    on<SetBatteryLimitLevelEvent>(
      (event, emit) => _setBatteryLimitLevelEvent(event, emit),
    );
  }

  void _setWifiOnlyDownloadEvent(
    SetWifiOnlyDownloadEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    emit(state.copyWith(wifiOnlyDownload: event.wifiOnlyDownload));
  }

  void _setShutDownWhenFinishDownloadEvent(
    SetShutDownWhenFinishDownloadEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    emit(state.copyWith(
        shutDownWhenFinishDownload: event.shutDownWhenFinishDownload));
  }

  void _setKeepRunningBackgroundEvent(
    SetKeepRunningBackgroundEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    emit(state.copyWith(keepRunningBackground: event.keepRunningBackground));
  }

  void _setKeepCpuAwakeEvent(
    SetKeepCpuAwakeEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    Wakelock.toggle(enable: event.keepCpuAwake);
    emit(state.copyWith(keepCpuAwake: event.keepCpuAwake));
  }

  void _setDownloadChargingConnectedEvent(
    SetDownloadChargingConnectedEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    emit(state.copyWith(
      downloadChargingConnected: event.downloadChargingConnected,
      currentBatteryState: event.currentBatteryState,
    ));
  }

  void _setShutDownWifiEvent(
    SetShutDownWifiEvent event,
    Emitter<PowerManagementState> emit,
  ) {
    emit(state.copyWith(shutDownWifi: event.shutDownWifi));
  }

  void _setBatteryLimitLevelEvent(
      SetBatteryLimitLevelEvent event, Emitter<PowerManagementState> emit) {
    emit(state.copyWith(
      batteryLimitLevel: event.batteryLimitLevel,
    ));
  }
}
