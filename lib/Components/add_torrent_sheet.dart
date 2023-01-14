import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/flood_snackbar.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTorrentSheet extends StatefulWidget {
  final ClientSettingsModel clientSettings;

  AddTorrentSheet({
    required this.clientSettings,
  });

  @override
  _AddTorrentSheetState createState() => _AddTorrentSheetState();
}

class _AddTorrentSheetState extends State<AddTorrentSheet> {
  bool isFileSelected = false;
  bool isMagnetSelected = false;
  bool useAdBasePath = false;
  bool completed = false;
  bool sequentialDownload = false;

  late TextEditingController directoryController;
  TextEditingController magnetUrlController = new TextEditingController();
  late String torrentPath;
  final _formKey = GlobalKey<FormState>();
  late String base64;

  @override
  void initState() {
    // TODO: implement initState
    directoryController =
        new TextEditingController(text: widget.clientSettings.directoryDefault);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        color: ThemeProvider.theme.primaryColorLight,
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              key: Key('Destination TextField'),
              controller: directoryController,
              style: TextStyle(
                color: ThemeProvider.theme.textTheme.bodyText1?.color,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.folder,
                  color: ThemeProvider.theme.textTheme.bodyText1?.color,
                ),
                labelText: 'Destination',
                hintText: 'Destination',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: ThemeProvider.theme.textTheme.bodyText1?.color),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            (isMagnetSelected)
                ? TextFormField(
                    key: Key('Torrent magnet link textfield'),
                    controller: magnetUrlController,
                    style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.link,
                        color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      ),
                      suffix: GestureDetector(
                        child: Icon(Icons.paste),
                        onTap: () {
                          FlutterClipboard.paste().then((value) {
                            setState(() {
                              magnetUrlController =
                                  TextEditingController(text: value);
                            });
                          });
                        },
                      ),
                      labelText: 'Torrent',
                      hintText: 'Torrent URL or Magnet Link',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          (value.isEmpty && isMagnetSelected)) {
                        return 'Field cannot be empty';
                      }
                      return null;
                    },
                  )
                : Container(),
            (isMagnetSelected)
                ? SizedBox(
                    height: 20,
                  )
                : Container(),
            CheckboxListTile(
              activeColor: ThemeProvider.theme.primaryColorDark,
              tileColor: ThemeProvider.theme.primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                'Use as Base Path',
                style: TextStyle(fontSize: 14),
              ),
              value: useAdBasePath,
              onChanged: (bool? value) {
                setState(() {
                  useAdBasePath = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: ThemeProvider.theme.primaryColorDark,
              tileColor: ThemeProvider.theme.primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                'Sequential Download',
                style: TextStyle(fontSize: 14),
              ),
              value: sequentialDownload,
              onChanged: (bool? value) {
                setState(() {
                  sequentialDownload = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: ThemeProvider.theme.primaryColorDark,
              tileColor: ThemeProvider.theme.primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                'Completed',
                style: TextStyle(fontSize: 14),
              ),
              value: completed,
              onChanged: (bool? value) {
                setState(() {
                  completed = value ?? false;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashColor: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    setState(() {
                      isMagnetSelected = true;
                      isFileSelected = false;
                    });
                  },
                  icon: Icon(FontAwesomeIcons.magnet),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'or',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  splashColor: Colors.white,
                  iconSize: 35,
                  onPressed: () async {
                    setState(() {
                      isFileSelected = true;
                      isMagnetSelected = false;
                    });
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ["torrent"]);
                    if (result == null) {
                      print('No file selected');
                    } else if (result.files.first.extension == "torrent") {
                      setState(() {
                        torrentPath = result.files.first.path!;
                      });
                      File torrentFile = new File(torrentPath);
                      List<int> imageBytes = torrentFile.readAsBytesSync();
                      setState(() {
                        base64 = base64Encode(imageBytes);
                      });
                      print(torrentPath.split('/').last);
                    } else {
                      print('Invalid');
                    }
                  },
                  icon: Icon(FontAwesomeIcons.solidFile),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &
                      (isMagnetSelected || isFileSelected)) {
                    if (isMagnetSelected) {
                      //The magnet link has been chosen
                      TorrentApi.addTorrentMagnet(
                          magnetUrl: magnetUrlController.text,
                          destination: directoryController.text,
                          isBasePath: useAdBasePath,
                          isSequential: sequentialDownload,
                          isCompleted: completed,
                          context: context);
                      Navigator.pop(context);
                    } else {
                      //The file has been chosen
                      TorrentApi.addTorrentFile(
                          base64: base64,
                          destination: directoryController.text,
                          isBasePath: useAdBasePath,
                          isSequential: sequentialDownload,
                          isCompleted: completed,
                          context: context);
                      Navigator.pop(context);
                    }
                  }
                  final addTorrentSnackbar = addFloodSnackBar(
                      SnackbarType.information,
                      'Torrent added successfully',
                      'Dismiss');

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(addTorrentSnackbar);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  primary: ThemeProvider.theme.primaryColorDark,
                ),
                child: Center(
                  child: Text(
                    "Add Torrent",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
