import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/settings_text_field.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class ConnectivitySection extends StatelessWidget {
  const ConnectivitySection(
      {Key? key,
      required this.portRangeController,
      required this.openPort,
      required this.maxHttpConnectionsController,
      required this.dhtPortController,
      required this.enableDht,
      required this.enablePeerExchange,
      required this.minimumPeerController,
      required this.maximumPeerController,
      required this.minimumPeerSeedingController,
      required this.maximumPeerSeedingController,
      required this.peerDesiredController,
      required this.clientSettingsBloc,
      required this.setEnableDht,
      required this.setEnablePeerExchange,
      required this.setOpenPort,
      required this.setRandomizePort,
      required this.randomizePort,
      required this.themeIndex})
      : super(key: key);

  final TextEditingController portRangeController;
  final bool openPort;
  final bool randomizePort;
  final TextEditingController maxHttpConnectionsController;
  final TextEditingController dhtPortController;
  final bool enableDht;
  final bool enablePeerExchange;
  final TextEditingController minimumPeerController;
  final TextEditingController maximumPeerController;
  final TextEditingController minimumPeerSeedingController;
  final TextEditingController maximumPeerSeedingController;
  final TextEditingController peerDesiredController;
  final ClientSettingsBloc clientSettingsBloc;
  final void Function(bool? value) setRandomizePort;
  final void Function(bool? value) setOpenPort;
  final Function? setEnableDht;
  final Function? setEnablePeerExchange;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ExpansionTileCard(
      key: Key('Connectivity Expansion Card'),
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      leading: Icon(FontAwesomeIcons.connectdevelop),
      title: MText(text: l10n.settings_tabs_connectivity),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Connectivity option display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(
                text: l10n.settings_connectivity_incoming_heading,
                themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_connectivity_port_range_label,
              labelText: l10n.settings_connectivity_port_range_label,
              isText: false,
              controller: portRangeController,
              themeIndex: themeIndex,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Randomize Port'),
                    activeColor: ThemeBloc.theme(themeIndex).primaryColorDark,
                    tileColor: ThemeBloc.theme(themeIndex).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      l10n.settings_connectivity_port_randomize_label,
                      style: TextStyle(fontSize: 12),
                    ),
                    value: randomizePort,
                    onChanged: setRandomizePort,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Open Port'),
                    activeColor: ThemeBloc.theme(themeIndex).primaryColorDark,
                    tileColor: ThemeBloc.theme(themeIndex).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      l10n.settings_connectivity_port_open_label,
                      style: TextStyle(fontSize: 12),
                    ),
                    value: openPort,
                    onChanged: setOpenPort,
                  ),
                )
              ],
            ),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_connectivity_max_http_connections,
              labelText: l10n.settings_connectivity_max_http_connections,
              isText: false,
              controller: maxHttpConnectionsController,
              themeIndex: themeIndex,
            ),
            SizedBox(height: 25),
            SText(
                text: l10n.settings_connectivity_dpd_heading,
                themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_connectivity_dht_port_label,
              labelText: l10n.settings_connectivity_dht_port_label,
              controller: dhtPortController,
              isText: false,
              themeIndex: themeIndex,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Enable DHT'),
                    activeColor: ThemeBloc.theme(themeIndex).primaryColorDark,
                    tileColor: ThemeBloc.theme(themeIndex).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      l10n.settings_connectivity_dht_label,
                      style: TextStyle(fontSize: 12),
                    ),
                    value: enableDht,
                    onChanged: (value) {
                      // setState(() {
                      //   enableDht = value;
                      // });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Enable Peer Exchange'),
                    activeColor: ThemeBloc.theme(themeIndex).primaryColorDark,
                    tileColor: ThemeBloc.theme(themeIndex).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      l10n.settings_connectivity_peer_exchange_label,
                      style: TextStyle(fontSize: 12),
                    ),
                    value: enablePeerExchange,
                    onChanged: (value) {
                      // setState(() {
                      //   enablePeerExchange = value;
                      // });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            SText(
                text: l10n.settings_connectivity_peers_heading,
                themeIndex: themeIndex),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_connectivity_peers_min_label,
                labelText: l10n.settings_connectivity_peers_min_label,
                controller: minimumPeerController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: l10n.settings_connectivity_peers_max_label,
              labelText: l10n.settings_connectivity_peers_max_label,
              controller: maximumPeerController,
              isText: false,
              themeIndex: themeIndex,
            ),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_connectivity_peers_seeding_min_label,
                labelText: l10n.settings_connectivity_peers_seeding_min_label,
                controller: minimumPeerSeedingController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_connectivity_peers_seeding_max_label,
                labelText: l10n.settings_connectivity_peers_seeding_max_label,
                controller: maximumPeerSeedingController,
                isText: false,
                themeIndex: themeIndex),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: l10n.settings_connectivity_peers_desired_label,
                labelText: l10n.settings_connectivity_peers_desired_label,
                controller: peerDesiredController,
                isText: false,
                themeIndex: themeIndex),
          ],
        )
      ],
    );
  }
}
