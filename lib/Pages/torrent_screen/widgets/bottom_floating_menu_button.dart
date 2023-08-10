import 'dart:convert';
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/add_torrent_file.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class BottomFloatingMenuButton extends StatefulWidget {
  final int themeIndex;

  const BottomFloatingMenuButton({Key? key, required this.themeIndex})
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
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return SpeedDial(
      buttonSize: Size(60, 60),
      backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
      foregroundColor: Colors.white,
      icon: Icons.add,
      activeIcon: Icons.close,
      spacing: 3,
      childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 4,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 500),
      overlayColor: BlocProvider.of<ThemeBloc>(context).isDarkMode
          ? Colors.grey[900]
          : Colors.white,
      children: [
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.solidFile),
          backgroundColor:
              ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
          foregroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
          label: l10n.floating_torrent_file,
          labelBackgroundColor: Colors.transparent,
          labelShadow: [
            BoxShadow(
              color: Colors.transparent,
            )
          ],
          labelStyle: TextStyle(
              color:
                  ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
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
                    BlocProvider.of<ClientSettingsBloc>(context)
                        .clientSettings
                        .directoryDefault;
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
                      ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                  builder: (context) {
                    return ListView(shrinkWrap: true, children: [
                      AddAutoTorrent(
                        base64: base64,
                        imageBytes: imageBytes,
                        uriString: torrentPath,
                        themeIndex: widget.themeIndex,
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
              ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
          foregroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
          label: l10n.floating_torrent_magnet,
          labelBackgroundColor: Colors.transparent,
          labelShadow: [
            BoxShadow(
              color: Colors.transparent,
            )
          ],
          labelStyle: TextStyle(
              color:
                  ThemeBloc.theme(widget.themeIndex).textTheme.bodyLarge?.color,
              fontSize: 14,
              fontWeight: FontWeight.w800),
          onTap: () {
            setState(() {
              isFileSelected = false;
              isMagnetSelected = true;
            });
            setState(() {
              directoryController.text =
                  BlocProvider.of<ClientSettingsBloc>(context)
                      .clientSettings
                      .directoryDefault;
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
                    ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                builder: (context) {
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ListView(shrinkWrap: true, children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 10),
                                child: Text(
                                  l10n.selected_magnet_link,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: ThemeBloc.theme(widget.themeIndex)
                                          .textTheme
                                          .bodyLarge
                                          ?.color),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        key: Key('MagnetUrl TextFormField'),
                                        controller: magnetUrlController,
                                        style: TextStyle(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.link,
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          suffix: GestureDetector(
                                            child: Icon(Icons.paste),
                                            onTap: () {
                                              FlutterClipboard.paste()
                                                  .then((value) {
                                                setState(() {
                                                  magnetUrlController.text =
                                                      value;
                                                });
                                              });
                                            },
                                          ),
                                          labelText: l10n.torrent_text,
                                          hintText: l10n
                                              .torrent_magnet_link_textfield_hint,
                                          labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
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
                                            return l10n
                                                .torrent_magnet_link_textfield_validator;
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: ThemeBloc.theme(widget.themeIndex)
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
                                        key: Key('Destination TextFormField'),
                                        controller: directoryController,
                                        style: TextStyle(
                                          color:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.folder,
                                            color: ThemeBloc.theme(
                                                    widget.themeIndex)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                          ),
                                          labelText: l10n
                                              .textfield_destination_torrent,
                                          hintText: l10n
                                              .textfield_destination_torrent,
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .textTheme
                                                  .bodyLarge
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
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                                StateSetter _setState) =>
                                            CheckboxListTile(
                                          activeColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorDark,
                                          tileColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorLight,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          title: Text(
                                            l10n.torrents_destination_base_path,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          value: useAdBasePath,
                                          onChanged: (bool? value) {
                                            _setState(() {
                                              useAdBasePath = value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                                StateSetter _setState) =>
                                            CheckboxListTile(
                                          activeColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorDark,
                                          tileColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorLight,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          title: Text(
                                            l10n.torrents_destination_sequential,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          value: sequentialDownload,
                                          onChanged: (bool? value) {
                                            _setState(() {
                                              sequentialDownload =
                                                  value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                                StateSetter _setState) =>
                                            CheckboxListTile(
                                          activeColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorDark,
                                          tileColor:
                                              ThemeBloc.theme(widget.themeIndex)
                                                  .primaryColorLight,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          title: Text(
                                            l10n.torrents_destination_completed,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          value: completed,
                                          onChanged: (bool? value) {
                                            _setState(() {
                                              completed = value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                                  isSequential:
                                                      sequentialDownload,
                                                  isCompleted: completed,
                                                  context: context);
                                              final addTorrentSnackbar =
                                                  addFloodSnackBar(
                                                      SnackbarType.information,
                                                      l10n.add_torrent_snackbar,
                                                      l10n.button_dismiss);

                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      addTorrentSnackbar);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: ThemeBloc.theme(
                                                      widget.themeIndex)
                                                  .primaryColorDark,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14.0),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                l10n.add_torrent_button,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]));
                },
              );
            });
          },
        ),
      ],
    );
  }
}
