import 'dart:convert';
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Api/torrent_api.dart';
import '../Constants/theme_provider.dart';
import '../Provider/client_provider.dart';

class BottomFloatingMenuButton extends StatefulWidget {
  final int index;

  const BottomFloatingMenuButton({Key? key, required this.index})
      : super(key: key);
  @override
  _BottomFloatingMenuButtonState createState() =>
      _BottomFloatingMenuButtonState();
}

class _BottomFloatingMenuButtonState extends State<BottomFloatingMenuButton>
    with TickerProviderStateMixin {
  bool isFileSelected = false;
  bool isMagnetSelected = false;
  bool useAdBasePath = false;
  bool completed = false;
  bool sequentialDownload = false;
  late String directoryDefault;

  final directoryController = TextEditingController();
  TextEditingController magnetUrlController = new TextEditingController();
  late String torrentPath;
  final _formKey = GlobalKey<FormState>();
  late String base64;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientSettingsProvider>(
        builder: (context, clientModel, child) {
      return SpeedDial(
        buttonSize: Size(60, 60),
        backgroundColor: ThemeProvider.theme(widget.index).primaryColorDark,
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        animationDuration: const Duration(milliseconds: 500),
        children: [
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.solidFile),
            backgroundColor:
                ThemeProvider.theme(widget.index).textTheme.bodyText1?.color,
            foregroundColor: ThemeProvider.theme(widget.index).primaryColorDark,
            label: 'Torrent File',
            labelBackgroundColor: Colors.transparent,
            labelShadow: [
              BoxShadow(
                color: Colors.transparent,
              )
            ],
            labelStyle: TextStyle(
                color: ThemeProvider.theme(widget.index)
                    .textTheme
                    .bodyText1
                    ?.color,
                fontSize: 14,
                fontWeight: FontWeight.w800),
            onTap: () async {
              setState(() {
                isFileSelected = true;
                isMagnetSelected = false;
              });
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom, allowedExtensions: ["torrent"]);
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
                setState(() {
                  directoryController.text =
                      clientModel.clientSettings.directoryDefault;
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    backgroundColor:
                        ThemeProvider.theme(widget.index).backgroundColor,
                    builder: (context) {
                      return ListView(shrinkWrap: true, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 5),
                                child: Text(
                                  "Selected Torrent File",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: ThemeProvider.theme(widget.index)
                                          .textTheme
                                          .bodyText1
                                          ?.color),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white38),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    color: ThemeProvider.theme(widget.index)
                                        .primaryColorLight,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.file_open),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                torrentPath
                                                            .split('/')
                                                            .last
                                                            .length >
                                                        20
                                                    ? torrentPath
                                                            .split('/')
                                                            .last
                                                            .substring(0, 20) +
                                                        '.torrent'
                                                    : torrentPath
                                                            .split('/')
                                                            .last +
                                                        '.torrent',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Montserrat',
                                                    color: ThemeProvider.theme(
                                                            widget.index)
                                                        .textTheme
                                                        .bodyText1
                                                        ?.color),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: ThemeProvider.theme(widget.index)
                                    .primaryColorLight,
                                padding: EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller: directoryController,
                                        style: TextStyle(
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.folder,
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyText1
                                                ?.color,
                                          ),
                                          labelText: 'Destination',
                                          hintText: 'Destination',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeProvider.theme(
                                                      widget.index)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CheckboxListTile(
                                        activeColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorDark,
                                        tileColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorLight,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                        activeColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorDark,
                                        tileColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorLight,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                        activeColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorDark,
                                        tileColor:
                                            ThemeProvider.theme(widget.index)
                                                .primaryColorLight,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            //The file has been chosen
                                            TorrentApi.addTorrentFile(
                                                base64: base64,
                                                destination:
                                                    directoryController.text,
                                                isBasePath: useAdBasePath,
                                                isSequential:
                                                    sequentialDownload,
                                                isCompleted: completed,
                                                context: context);
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                            ),
                                            primary: ThemeProvider.theme(
                                                    widget.index)
                                                .primaryColorDark,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Add Torrent",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    },
                  );
                });
              } else {
                print('Invalid');
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.magnet),
            backgroundColor:
                ThemeProvider.theme(widget.index).textTheme.bodyText1?.color,
            foregroundColor: ThemeProvider.theme(widget.index).primaryColorDark,
            label: 'Magnet Link',
            labelBackgroundColor: Colors.transparent,
            labelShadow: [
              BoxShadow(
                color: Colors.transparent,
              )
            ],
            labelStyle: TextStyle(
                color: ThemeProvider.theme(widget.index)
                    .textTheme
                    .bodyText1
                    ?.color,
                fontSize: 14,
                fontWeight: FontWeight.w800),
            onTap: () {
              setState(() {
                isFileSelected = false;
                isMagnetSelected = true;
              });
              setState(() {
                directoryController.text =
                    clientModel.clientSettings.directoryDefault;
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  backgroundColor:
                      ThemeProvider.theme(widget.index).backgroundColor,
                  builder: (context) {
                    return ListView(shrinkWrap: true, children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, bottom: 10),
                              child: Text(
                                "Selected Magnet Link",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    color: ThemeProvider.theme(widget.index)
                                        .textTheme
                                        .bodyText1
                                        ?.color),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: magnetUrlController,
                                      style: TextStyle(
                                        color: ThemeProvider.theme(widget.index)
                                            .textTheme
                                            .bodyText1
                                            ?.color,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.link,
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                        ),
                                        suffix: GestureDetector(
                                          child: Icon(Icons.paste),
                                          onTap: () {
                                            FlutterClipboard.paste()
                                                .then((value) {
                                              setState(() {
                                                magnetUrlController =
                                                    TextEditingController(
                                                        text: value);
                                              });
                                            });
                                          },
                                        ),
                                        labelText: 'Torrent',
                                        hintText: 'Torrent URL or Magnet Link',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null ||
                                            (value.isEmpty &&
                                                isMagnetSelected)) {
                                          return 'Field cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: ThemeProvider.theme(widget.index)
                                  .primaryColorLight,
                              padding: EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      controller: directoryController,
                                      style: TextStyle(
                                        color: ThemeProvider.theme(widget.index)
                                            .textTheme
                                            .bodyText1
                                            ?.color,
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.folder,
                                          color:
                                              ThemeProvider.theme(widget.index)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.color,
                                        ),
                                        labelText: 'Destination',
                                        hintText: 'Destination',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeProvider.theme(
                                                    widget.index)
                                                .textTheme
                                                .bodyText1
                                                ?.color),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      activeColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorDark,
                                      tileColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorLight,
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
                                      activeColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorDark,
                                      tileColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorLight,
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
                                      activeColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorDark,
                                      tileColor:
                                          ThemeProvider.theme(widget.index)
                                              .primaryColorLight,
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
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          //The file has been chosen
                                          TorrentApi.addTorrentMagnet(
                                              magnetUrl:
                                                  magnetUrlController.text,
                                              destination:
                                                  directoryController.text,
                                              isBasePath: useAdBasePath,
                                              isSequential: sequentialDownload,
                                              isCompleted: completed,
                                              context: context);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                          primary:
                                              ThemeProvider.theme(widget.index)
                                                  .primaryColorDark,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Add Torrent",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  },
                );
              });
            },
          ),
        ],
      );
    });
  }
}
