import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/settings_text_field.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class ResourceSection extends StatelessWidget {
  const ResourceSection({
    Key? key,
    required this.defaultDownloadDirectoryController,
    required this.maximumOpenFilesController,
    required this.verifyHash,
    required this.maxMemoryUsageController,
    required this.setVerifyHash,
    required this.themeIndex,
  }) : super(key: key);

  final TextEditingController defaultDownloadDirectoryController;
  final TextEditingController maximumOpenFilesController;
  final bool verifyHash;
  final TextEditingController maxMemoryUsageController;
  final void Function(bool? value) setVerifyHash;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ExpansionTileCard(
      key: Key('Resources Expansion Card'),
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      title: MText(text: l10n.settings_tabs_resources),
      leading: Icon(Icons.settings),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Resources options display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(
                text: l10n.settings_resources_disk_heading,
                themeIndex: themeIndex),
            SizedBox(height: 25),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_resources_disk_download_location_label,
              labelText: l10n.settings_resources_disk_download_location_label,
              controller: defaultDownloadDirectoryController,
              themeIndex: themeIndex,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: SettingsTextField(
                    validator: (value) {
                      return null;
                    },
                    hintText: l10n.settings_resources_max_open_files,
                    labelText: l10n.settings_resources_max_open_files,
                    controller: maximumOpenFilesController,
                    isText: false,
                    themeIndex: themeIndex,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      CheckboxListTile(
                        key: Key('Verify Hash checkbox'),
                        activeColor:
                            ThemeBloc.theme(themeIndex).colorScheme.background,
                        tileColor:
                            ThemeBloc.theme(themeIndex).primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Text(
                          l10n.settings_resources_disk_check_hash_label,
                          style: TextStyle(fontSize: 12),
                        ),
                        value: verifyHash,
                        onChanged: setVerifyHash,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            SText(
                text: l10n.settings_resources_memory_heading,
                themeIndex: themeIndex),
            SizedBox(height: 25),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_resources_memory_max_label,
              labelText: l10n.settings_resources_memory_max_label,
              controller: maxMemoryUsageController,
              isText: false,
              themeIndex: themeIndex,
            ),
          ],
        )
      ],
    );
  }
}
