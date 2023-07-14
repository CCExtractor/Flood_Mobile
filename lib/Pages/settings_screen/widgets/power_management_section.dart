import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:flood_mobile/Blocs/power_management_bloc/power_management_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';

// ignore: must_be_immutable
class PowerManagementSection extends StatelessWidget {
  final int themeIndex;

  PowerManagementSection({
    Key? key,
    required this.themeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ExpansionTileCard(
      key: Key('Power Management Expansion Card'),
      initiallyExpanded: false,
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      title: MText(text: l10n.settings_tabs_power_management),
      leading: Icon(Icons.power_settings_new),
      contentPadding: EdgeInsets.all(0),
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      children: [
        BlocBuilder<PowerManagementBloc, PowerManagementState>(
          builder: (context, state) {
            double batteryLevel = state.batteryLimitLevel.toDouble();
            return Column(
              key: Key('Power management options display column'),
              children: [
                SwitchListTile(
                  title: Text(l10n.wifi_only_title),
                  subtitle: Text(
                    l10n.wifi_only_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  value: state.wifiOnlyDownload,
                  onChanged: (newValue) {
                    BlocProvider.of<PowerManagementBloc>(context).add(
                      SetWifiOnlyDownloadEvent(wifiOnlyDownload: newValue),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                SwitchListTile(
                  title: Text(l10n.shutdown_when_download_completes_title),
                  subtitle: Text(
                    l10n.shutdown_when_download_completes_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  value: state.shutDownWhenFinishDownload,
                  onChanged: (newValue) {
                    BlocProvider.of<PowerManagementBloc>(context).add(
                      SetShutDownWhenFinishDownloadEvent(
                          shutDownWhenFinishDownload: newValue),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                SwitchListTile(
                  title: Text(l10n.keep_CPU_awake_title),
                  subtitle: Text(
                    l10n.keep_CPU_awake_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  value: state.keepCpuAwake,
                  onChanged: (newValue) {
                    BlocProvider.of<PowerManagementBloc>(context).add(
                      SetKeepCpuAwakeEvent(keepCpuAwake: newValue),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                SwitchListTile(
                  title: Text(l10n.charging_only_title),
                  subtitle: Text(
                    l10n.charging_only_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  value: state.downloadChargingConnected,
                  onChanged: (newValue) {
                    BlocProvider.of<PowerManagementBloc>(context).add(
                      SetDownloadChargingConnectedEvent(
                          downloadChargingConnected: newValue),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                SwitchListTile(
                  title: Text(l10n.shut_down_wifi_title),
                  subtitle: Text(
                    l10n.shut_down_wifi_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  value: state.shutDownWifi,
                  onChanged: (newValue) {
                    BlocProvider.of<PowerManagementBloc>(context).add(
                      SetShutDownWifiEvent(shutDownWifi: newValue),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                ListTile(
                  title: Text(
                    l10n.battery_optimization_title,
                  ),
                  subtitle: Text(
                    l10n.battery_optimization_subtitle,
                    style: TextStyle(fontSize: 13),
                  ),
                  onTap: () {
                    OptimizeBattery.openBatteryOptimizationSettings();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.battery_low_title,
                        ),
                        Text(batteryLevel.toStringAsFixed(0) + ' %'),
                      ],
                    ),
                    subtitle: SliderTheme(
                      data: SliderThemeData(trackShape: CustomTrackShape()),
                      child: Slider(
                        value: batteryLevel,
                        min: 0.0,
                        max: 100.0,
                        label: batteryLevel.round().toString() + '%',
                        onChanged: (value) {
                          setState(() {
                            batteryLevel = value;
                          });
                        },
                        onChangeEnd: (value) {
                          BlocProvider.of<PowerManagementBloc>(context).add(
                            SetBatteryLimitLevelEvent(
                                batteryLimitLevel: value.toInt()),
                          );
                        },
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  );
                }),
              ],
            );
          },
        )
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
