import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/settings_text_field.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class BandwidthSection extends StatelessWidget {
  const BandwidthSection({
    Key? key,
    required this.globalDownloadRateController,
    required this.globalUploadRateController,
    required this.uploadSlotPerTorrentController,
    required this.uploadSlotGlobalController,
    required this.downloadSlotPerTorrentController,
    required this.downloadSlotGlobalController,
    required this.themeIndex,
  }) : super(key: key);

  final TextEditingController globalDownloadRateController;
  final TextEditingController globalUploadRateController;
  final TextEditingController uploadSlotPerTorrentController;
  final TextEditingController uploadSlotGlobalController;
  final TextEditingController downloadSlotPerTorrentController;
  final TextEditingController downloadSlotGlobalController;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ExpansionTileCard(
      key: Key('Bandwidth Expansion Card'),
      initiallyExpanded: true,
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      title: MText(text: l10n.settings_tabs_bandwidth),
      leading: Icon(Icons.wifi_rounded),
      contentPadding: EdgeInsets.all(0),
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      children: [
        Column(
          key: Key('Bandwidth option display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(
                text: l10n.settings_bandwidth_transferrate_heading,
                themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n
                    .settings_bandwidth_transferrate_global_throttle_download,
                labelText: l10n
                    .settings_bandwidth_transferrate_global_throttle_download,
                isText: false,
                controller: globalDownloadRateController,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText:
                    l10n.settings_bandwidth_transferrate_global_throttle_upload,
                labelText:
                    l10n.settings_bandwidth_transferrate_global_throttle_upload,
                isText: false,
                controller: globalUploadRateController,
                themeIndex: themeIndex),
            SizedBox(height: 25),
            SText(
                text: l10n.settings_bandwidth_slots_heading,
                themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_bandwidth_slots_upload_label,
                labelText: l10n.settings_bandwidth_slots_upload_label,
                isText: false,
                controller: uploadSlotPerTorrentController,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_bandwidth_slots_upload_global_label,
                labelText: l10n.settings_bandwidth_slots_upload_global_label,
                controller: uploadSlotGlobalController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_bandwidth_slots_download_label,
                labelText: l10n.settings_bandwidth_slots_download_label,
                controller: downloadSlotPerTorrentController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_bandwidth_slots_download_global_label,
              labelText: l10n.settings_bandwidth_slots_download_global_label,
              controller: downloadSlotGlobalController,
              isText: false,
              themeIndex: themeIndex,
            ),
          ],
        )
      ],
    );
  }
}
