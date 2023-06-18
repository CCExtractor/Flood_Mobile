import 'dart:convert';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddAutoTorrent extends StatefulWidget {
  String base64;
  List<int> imageBytes;
  String? uriString;
  final int themeIndex;
  AddAutoTorrent({
    required this.base64,
    required this.imageBytes,
    required this.uriString,
    required this.themeIndex,
  });

  @override
  _AddAutoTorrentState createState() => _AddAutoTorrentState();
}

class _AddAutoTorrentState extends State<AddAutoTorrent> {
  bool useAdBasePath = false;
  bool completed = false;
  bool sequentialDownload = false;
  final directoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String fileSelectedName = "";

  @override
  void initState() {
    super.initState();
    _getDefaultDirectory();
    _addAndGetTorrent();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5),
              child: Text(
                context.l10n.selected_torrent_file,
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
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ThemeBloc.themeMode == ThemeMode.light
                          ? Colors.black38
                          : Colors.white38),
                  borderRadius: BorderRadius.circular(8),
                  color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          Icon(Icons.file_open),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              fileSelectedName.length > 25
                                  ? fileSelectedName.substring(0, 25) +
                                      '.torrent'
                                  : fileSelectedName + '.torrent',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  color: ThemeBloc.theme(widget.themeIndex)
                                      .textTheme
                                      .bodyLarge
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
              color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: directoryController,
                      style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.folder,
                          color: ThemeBloc.theme(widget.themeIndex)
                              .textTheme
                              .bodyLarge
                              ?.color,
                        ),
                        labelText: context.l10n.textfield_destination_torrent,
                        hintText: context.l10n.textfield_destination_torrent,
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeBloc.theme(widget.themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CheckboxListTile(
                      activeColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                      tileColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(
                        context.l10n.torrents_destination_base_path,
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
                          ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                      tileColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(
                        context.l10n.torrents_destination_sequential,
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
                          ThemeBloc.theme(widget.themeIndex).primaryColorDark,
                      tileColor:
                          ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(
                        context.l10n.torrents_destination_completed,
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () async {
                          widget.base64 = base64Encode(widget.imageBytes);
                          //The file has been chosen
                          TorrentApi.addTorrentFile(
                              base64: widget.base64,
                              destination: directoryController.text,
                              isBasePath: useAdBasePath,
                              isSequential: sequentialDownload,
                              isCompleted: completed,
                              context: context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ThemeBloc.theme(widget.themeIndex)
                              .primaryColorDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            context.l10n.add_torrent_button,
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
  }

  void _addAndGetTorrent() {
    widget.base64 = base64Encode(widget.imageBytes);
    fileSelectedName = widget.uriString.toString().split("/").last;
  }

  void _getDefaultDirectory() {
    directoryController.text = BlocProvider.of<ClientSettingsBloc>(context)
        .clientSettings
        .directoryDefault
        .toString();
  }
}
