part of 'power_management_bloc.dart';

class PowerManagementState extends Equatable {
  final bool wifiOnlyDownload;
  final bool shutDownWhenFinishDownload;
  final bool keepRunningBackground;
  final bool keepCpuAwake;
  final bool downloadChargingConnected;
  final bool shutDownWifi;
  final BatteryState currentBatteryState;
  final int batteryLimitLevel;

  const PowerManagementState({
    required this.wifiOnlyDownload,
    required this.shutDownWhenFinishDownload,
    required this.keepRunningBackground,
    required this.keepCpuAwake,
    required this.downloadChargingConnected,
    required this.currentBatteryState,
    required this.shutDownWifi,
    required this.batteryLimitLevel,
  });

  factory PowerManagementState.initial() => PowerManagementState(
        wifiOnlyDownload: false,
        shutDownWhenFinishDownload: false,
        keepRunningBackground: false,
        keepCpuAwake: false,
        downloadChargingConnected: false,
        currentBatteryState: BatteryState.unknown,
        shutDownWifi: false,
        batteryLimitLevel: 0,
      );

  PowerManagementState copyWith({
    bool? wifiOnlyDownload,
    bool? shutDownWhenFinishDownload,
    bool? keepRunningBackground,
    bool? keepCpuAwake,
    bool? downloadChargingConnected,
    BatteryState? currentBatteryState,
    bool? shutDownWifi,
    int? batteryLimitLevel,
  }) =>
      PowerManagementState(
        wifiOnlyDownload: wifiOnlyDownload ?? this.wifiOnlyDownload,
        shutDownWhenFinishDownload:
            shutDownWhenFinishDownload ?? this.shutDownWhenFinishDownload,
        keepRunningBackground:
            keepRunningBackground ?? this.keepRunningBackground,
        keepCpuAwake: keepCpuAwake ?? this.keepCpuAwake,
        downloadChargingConnected:
            downloadChargingConnected ?? this.downloadChargingConnected,
        currentBatteryState: currentBatteryState ?? this.currentBatteryState,
        shutDownWifi: shutDownWifi ?? this.shutDownWifi,
        batteryLimitLevel: batteryLimitLevel ?? this.batteryLimitLevel,
      );

  @override
  List<Object> get props => [
        wifiOnlyDownload,
        shutDownWhenFinishDownload,
        keepRunningBackground,
        keepCpuAwake,
        downloadChargingConnected,
        currentBatteryState,
        shutDownWifi,
        batteryLimitLevel,
      ];
}
