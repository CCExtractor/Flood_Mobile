import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
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
                          hintText: 'Dropdown Presets: Download',
                          labelText: 'Dropdown Presets: Download',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Dropdown Presets: Upload',
                          labelText: 'Dropdown Presets: Upload',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Global Download Rate Throttle',
                          labelText: 'Global Download Rate Throttle',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Global Upload Rate Throttle',
                          labelText: 'Global Upload Rate Throttle',
                        ),
                        SizedBox(height: 25),
                        SText(text: 'Slot Availability'),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Upload Slots Per Torrent',
                          labelText: 'Upload Slots Per Torrent',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Upload Slots Global',
                          labelText: 'Upload Slots Global',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Download Slots Per Torrent',
                          labelText: 'Download Slots Per Torrent',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Download Slots Global',
                          labelText: 'Download Slots Global',
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
                                title: Text('Randomize Port'),
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
                                title: Text('Open Port'),
                                value: false,
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
                        ),
                        SizedBox(height: 25),
                        SText(text: 'Decentralized Peer Discovery'),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'DHT Port',
                          labelText: 'DHT Port',
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
                                title: Text('Enable DHT'),
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
                                title: Text('Enable Peer Exchange'),
                                value: false,
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
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Maximum Peers',
                          labelText: 'Maximum Peers',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Minimum Peers Seeding',
                          labelText: 'Minimum Peers Seeding',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Maximum Peers Seeding',
                          labelText: 'Maximum Peers Seeding',
                        ),
                        SizedBox(height: 22),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Peers Desired',
                          labelText: 'Peers Desired',
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
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Default Download Directory',
                          labelText: 'Default Download Directory',
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
                                title: Text('Verify Hash'),
                                value: false,
                                onChanged: (value) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        SText(text: 'Memory'),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Max Memory Usage (MB)',
                          labelText: 'Max Memory Usage (MB)',
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
                        SizedBox(height: 15),
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
                                title: Text('Verify Hash'),
                                value: false,
                                onChanged: (value) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        SText(text: 'Add User'),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Username',
                          labelText: 'Username',
                        ),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        SizedBox(height: 15),
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
                                title: Text('Is Admin'),
                                value: false,
                                onChanged: (value) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
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
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                tileColor: AppColor.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text('Socket'),
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
                                title: Text('TCP'),
                                value: false,
                                onChanged: (value) {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        SettingsTextField(
                          validator: (value) {},
                          hintText: 'eg. ~/.local/share/rtorrent',
                          labelText: 'Path',
                        ),
                        SizedBox(height: 15),
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
  }
}
