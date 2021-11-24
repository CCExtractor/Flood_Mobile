import 'dart:io';
import 'dart:math' as math;

import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Components/base_app_bar.dart';
import 'package:flood_mobile/Components/toast_component.dart';
import 'package:flood_mobile/Components/torrent_content_tile.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Provider/torrent_content_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class TorrentContentScreen extends StatefulWidget {
  final TorrentContentPageArguments arguments;

  TorrentContentScreen({required this.arguments});

  @override
  _TorrentContentScreenState createState() => _TorrentContentScreenState();
}

class _TorrentContentScreenState extends State<TorrentContentScreen> {
  static downloadingCallback(id, status, progress) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TorrentContentProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: (!model.isSelectionMode)
            ? BaseAppBar(
                appBar: AppBar(),
              )
            : AppBar(
                title: Image(
                  image: AssetImage(
                    'assets/images/icon.png',
                  ),
                  width: 60,
                  height: 60,
                ),
                centerTitle: true,
                backgroundColor: ThemeProvider.theme.primaryColor,
                elevation: 0,
                leading: Row(
                  children: [
                    Transform.rotate(
                      angle: 45 * math.pi / 180,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
                        ),
                        onPressed: () {
                          model.setSelectionMode(newIsSelected: false);
                          model.removeAllItemsFromList();
                        },
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.download_rounded,
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    ),
                    onPressed: () async {
                      try {
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          String downloadFileIndexList = '';
                          for (int i in (Provider.of<TorrentContentProvider>(
                                  context,
                                  listen: false)
                              .selectedIndexList)) {
                            if (downloadFileIndexList != '') {
                              downloadFileIndexList += ',';
                            }
                            downloadFileIndexList += i.toString();
                          }
                          print(downloadFileIndexList);
                          final Directory? externalDir =
                              await getExternalStorageDirectory();
                          if (externalDir == null) {
                            //TODO(pratik): check message
                            Toasts.showFailToast(msg: 'File not present');
                          } else {
                            FlutterDownloader.enqueue(
                                url:
                                    "${Provider.of<ApiProvider>(context, listen: false).baseUrl}/api/torrents/${widget.arguments.hash}/contents/${downloadFileIndexList}/data",
                                savedDir: externalDir.path,
                                showNotification: true,
                                openFileFromNotification: true,
                                headers: {
                                  'Cookie': Provider.of<UserDetailProvider>(
                                          context,
                                          listen: false)
                                      .token
                                });
                          }
                        } else {
                          Toasts.showFailToast(msg: 'Permission Denied');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  PopupMenuButton<String>(
                    color: ThemeProvider.theme.backgroundColor,
                    icon: Icon(
                      Icons.more_vert,
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    ),
                    onSelected: (value) {
                      if (value == 'High Priority') {
                        TorrentApi.setTorrentContentPriority(
                            context: context,
                            hash: widget.arguments.hash,
                            priorityType: 2,
                            indexList: Provider.of<TorrentContentProvider>(
                                    context,
                                    listen: false)
                                .selectedIndexList);
                        model.removeAllItemsFromList();
                        model.setSelectionMode(newIsSelected: false);
                      }
                      if (value == 'Normal Priority') {
                        TorrentApi.setTorrentContentPriority(
                            context: context,
                            hash: widget.arguments.hash,
                            priorityType: 1,
                            indexList: Provider.of<TorrentContentProvider>(
                                    context,
                                    listen: false)
                                .selectedIndexList);
                        model.removeAllItemsFromList();
                        model.setSelectionMode(newIsSelected: false);
                        print(1);
                      }
                      if (value == 'Don\'t Download') {
                        TorrentApi.setTorrentContentPriority(
                            context: context,
                            hash: widget.arguments.hash,
                            priorityType: 0,
                            indexList: Provider.of<TorrentContentProvider>(
                                    context,
                                    listen: false)
                                .selectedIndexList);
                        model.removeAllItemsFromList();
                        model.setSelectionMode(newIsSelected: false);
                        print(0);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {
                        'High Priority',
                        'Normal Priority',
                        'Don\'t Download'
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ThemeProvider.theme.primaryColor,
          child: StreamBuilder(
            stream: TorrentApi.getTorrentContent(
                context: context, hash: widget.arguments.hash),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                List<String> folderList = [];
                Map<String, dynamic> data = snapshot.data;
                data.forEach((key, value) {
                  folderList.add(key);
                });
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Files',
                          style: GoogleFonts.notoSans(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.storage),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                widget.arguments.directory,
                                style: GoogleFonts.notoSans(
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: ThemeProvider.theme.primaryColorDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      FolderFileListView(
                        data: snapshot.data,
                        depth: 0,
                        hash: widget.arguments.hash,
                      ),
                    ],
                  ),
                );
              }
              return SpinKitFadingCircle(
                color: ThemeProvider.theme.primaryColorDark,
              );
            },
          ),
        ),
      );
    });
  }
}
