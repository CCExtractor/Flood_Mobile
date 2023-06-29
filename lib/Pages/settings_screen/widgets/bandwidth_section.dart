import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/settings_text_field.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';

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
    return ExpansionTileCard(
      key: Key('Bandwidth Expansion Card'),
      initiallyExpanded: true,
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      title: MText(text: 'Bandwidth'),
      leading: Icon(Icons.wifi_rounded),
      contentPadding: EdgeInsets.all(0),
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      children: [
        Column(
          key: Key('Bandwidth option display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(text: 'Transfer Rate Throttles', themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Global Download Rate Throttle',
                labelText: 'Global Download Rate Throttle',
                isText: false,
                controller: globalDownloadRateController,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Global Upload Rate Throttle',
                labelText: 'Global Upload Rate Throttle',
                isText: false,
                controller: globalUploadRateController,
                themeIndex: themeIndex),
            SizedBox(height: 25),
            SText(text: 'Slot Availability', themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Upload Slots Per Torrent',
                labelText: 'Upload Slots Per Torrent',
                isText: false,
                controller: uploadSlotPerTorrentController,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Upload Slots Global',
                labelText: 'Upload Slots Global',
                controller: uploadSlotGlobalController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Download Slots Per Torrent',
                labelText: 'Download Slots Per Torrent',
                controller: downloadSlotPerTorrentController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Download Slots Global',
              labelText: 'Download Slots Global',
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
