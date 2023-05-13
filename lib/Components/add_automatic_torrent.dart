import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/api_provider.dart';
import '../Provider/user_detail_provider.dart';

// ignore: must_be_immutable
class AddAutoTorrent extends StatefulWidget {
  String base64;
  List<int> imageBytes;
  String? uriString;

  AddAutoTorrent({
    required this.base64,
    required this.imageBytes,
    required this.uriString,
  });

  @override
  _AddAutoTorrentState createState() => _AddAutoTorrentState();
}

class _AddAutoTorrentState extends State<AddAutoTorrent> {
  bool useAdBasePath = false;
  bool completed = false;
  bool sequentialDownload = false;
  late String directoryDefault;
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
                "Selected Torrent File",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: ThemeProvider.theme.textTheme.bodyLarge?.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: ThemeProvider.themeMode == ThemeMode.light
                          ? Colors.black38
                          : Colors.white38),
                  borderRadius: BorderRadius.circular(8),
                  color: ThemeProvider.theme.primaryColorLight,
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
                                  color: ThemeProvider
                                      .theme.textTheme.bodyLarge?.color),
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
              color: ThemeProvider.theme.primaryColorLight,
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
                        color: ThemeProvider.theme.textTheme.bodyLarge?.color,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.folder,
                          color: ThemeProvider.theme.textTheme.bodyLarge?.color,
                        ),
                        labelText: 'Destination',
                        hintText: 'Destination',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color:
                                ThemeProvider.theme.textTheme.bodyLarge?.color),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                          backgroundColor: ThemeProvider.theme.primaryColorDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
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
  }

  Future<void> _getDefaultDirectory() async {
    String url = Provider.of<ApiProvider>(context, listen: false).baseUrl +
        ApiProvider.getClientSettingsUrl;
    print('---GET CLIENT SETTINGS---');
    print(url);
    Response response;
    Dio dio = new Dio();
    //Headers
    dio.options.headers['Accept'] = "application/json";
    dio.options.headers['Content-Type'] = "application/json";
    dio.options.headers['Connection'] = "keep-alive";
    dio.options.headers['Cookie'] =
        Provider.of<UserDetailProvider>(context, listen: false).token;
    response = await dio.get(
      url,
    );
    if (response.statusCode == 200) {
      print('---CLIENT SETTINGS---');
      directoryDefault = response.data['directoryDefault'];
      directoryController.text = directoryDefault;
    }
  }

  Future<void> _addAndGetTorrent() async {
    widget.base64 = base64Encode(widget.imageBytes);
    fileSelectedName = widget.uriString.toString().split("/").last;
  }
}
