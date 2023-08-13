part of 'power_management_bloc.dart';

abstract class PowerManagementEvent extends Equatable {
  const PowerManagementEvent();

  @override
  List<Object> get props => [];
}

class SetWifiOnlyDownloadEvent extends PowerManagementEvent {
  final bool wifiOnlyDownload;

  const SetWifiOnlyDownloadEvent({required this.wifiOnlyDownload});

  @override
  List<Object> get props => [wifiOnlyDownload];
}

class SetShutDownWhenFinishDownloadEvent extends PowerManagementEvent {
  final bool shutDownWhenFinishDownload;

  const SetShutDownWhenFinishDownloadEvent(
      {required this.shutDownWhenFinishDownload});

  @override
  List<Object> get props => [shutDownWhenFinishDownload];
}

class SetKeepRunningBackgroundEvent extends PowerManagementEvent {
  final bool keepRunningBackground;

  const SetKeepRunningBackgroundEvent({required this.keepRunningBackground});

  @override
  List<Object> get props => [keepRunningBackground];
}

class SetKeepCpuAwakeEvent extends PowerManagementEvent {
  final bool keepCpuAwake;

  const SetKeepCpuAwakeEvent({required this.keepCpuAwake});

  @override
  List<Object> get props => [keepCpuAwake];
}

class SetShutDownWifiEvent extends PowerManagementEvent {
  final bool shutDownWifi;

  const SetShutDownWifiEvent({required this.shutDownWifi});

  @override
  List<Object> get props => [shutDownWifi];
}

class SetDownloadChargingConnectedEvent extends PowerManagementEvent {
  final bool? downloadChargingConnected;
  final BatteryState? currentBatteryState;
  const SetDownloadChargingConnectedEvent(
      {this.downloadChargingConnected, this.currentBatteryState});

  @override
  List<Object> get props => [
        downloadChargingConnected ?? false,
        currentBatteryState ?? BatteryState.unknown
      ];
}

class SetBatteryLimitLevelEvent extends PowerManagementEvent {
  final int batteryLimitLevel;

  const SetBatteryLimitLevelEvent({required this.batteryLimitLevel});

  @override
  List<Object> get props => [batteryLimitLevel];
}
