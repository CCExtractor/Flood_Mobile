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
                //Bandwidth Section
                SizedBox(height: 30),
                MText(text: 'Bandwidth'),
                SizedBox(height: 20),
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
                //TODO Connectivity
                SizedBox(height: 30),
                MText(text: 'Connectivity'),
                SizedBox(height: 20),
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
                //TODO Resources
                //TODO Authentication
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
