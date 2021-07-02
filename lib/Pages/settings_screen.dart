import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/torrent_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<ClientSettingsProvider>(
        builder: (context, clientSettingsModel, child) {
      return KeyboardDismissOnTap(
        child: Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LText(text: 'Settings'),
                  //TODO:Bandwidth Section
                  SizedBox(height: 30),
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Bandwidth'),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Transfer Rate Throttles'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Global Download Rate Throttle',
                            labelText: 'Global Download Rate Throttle',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleGlobalDownSpeed
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Global Upload Rate Throttle',
                            labelText: 'Global Upload Rate Throttle',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleGlobalUpSpeed
                                .toString(),
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Slot Availability'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Upload Slots Per Torrent',
                            labelText: 'Upload Slots Per Torrent',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxUploads
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Upload Slots Global',
                            labelText: 'Upload Slots Global',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxUploadsGlobal
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Download Slots Per Torrent',
                            labelText: 'Download Slots Per Torrent',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxDownloads
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Download Slots Global',
                            labelText: 'Download Slots Global',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxDownloadsGlobal
                                .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Connectivity
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Connectivity'),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Incoming Connections'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Port Range',
                            labelText: 'Port Range',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.networkPortRange
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Randomize Port',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: clientSettingsModel
                                      .clientSettings.networkPortRandom,
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Open Port',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: clientSettingsModel
                                      .clientSettings.networkPortOpen,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Reported IP/Hostname',
                            labelText: 'Reported IP/Hostname',
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum HTTP Connections',
                            labelText: 'Maximum HTTP Connections',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.networkHttpMaxOpen
                                .toString(),
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Decentralized Peer Discovery'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'DHT Port',
                            labelText: 'DHT Port',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.dhtPort
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Enable DHT',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: clientSettingsModel.clientSettings.dht,
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Enable Peer Exchange',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: clientSettingsModel
                                      .clientSettings.protocolPex,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Peers'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Minimum Peers',
                            labelText: 'Minimum Peers',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMinPeersNormal
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum Peers',
                            labelText: 'Maximum Peers',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxPeersNormal
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Minimum Peers Seeding',
                            labelText: 'Minimum Peers Seeding',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMinPeersSeed
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum Peers Seeding',
                            labelText: 'Maximum Peers Seeding',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.throttleMaxPeersSeed
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Peers Desired',
                            labelText: 'Peers Desired',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.trackersNumWant
                                .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Resources
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Resources'),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Disk'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Default Download Directory',
                            labelText: 'Default Download Directory',
                            defaultValue: clientSettingsModel
                                .clientSettings.directoryDefault
                                .toString(),
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: SettingsTextField(
                                  validator: (value) {},
                                  hintText: 'Maximum Open Files',
                                  labelText: 'Maximum Open Files',
                                  isText: false,
                                  defaultValue: clientSettingsModel
                                      .clientSettings.networkMaxOpenFiles
                                      .toString(),
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
                                      activeColor: AppColor.greenAccentColor,
                                      tileColor: AppColor.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      title: Text(
                                        'Verify Hash',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      value: clientSettingsModel.clientSettings
                                          .piecesHashOnCompletion,
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Memory'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Max Memory Usage (MB)',
                            labelText: 'Max Memory Usage (MB)',
                            isText: false,
                            defaultValue: clientSettingsModel
                                .clientSettings.piecesMemoryMax
                                .toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Authentication
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Authentication'),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'User Accounts'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Current User',
                            labelText: 'Current User',
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: SettingsTextField(
                                  validator: (value) {},
                                  hintText: 'Maximum Open Files',
                                  labelText: 'Maximum Open Files',
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Verify Hash',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Add User'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Username',
                            labelText: 'Username',
                          ),
                          SizedBox(height: 20),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Is Admin',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: 'rTorrent',
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                      dropdownColor: AppColor.secondaryColor,
                                      elevation: 16,
                                      onChanged: (String newValue) {},
                                      underline: Container(),
                                      items: <String>[
                                        'rTorrent',
                                        'qBittorrent',
                                        'Transmission',
                                        'Deluge'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Socket',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'TCP',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'eg. ~/.local/share/rtorrent',
                            labelText: 'Path',
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                child: Container(
                                  height: hp * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      primary: AppColor.blueAccentColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
