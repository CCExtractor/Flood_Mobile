import 'dart:io';
import 'dart:math' as math;
import 'package:flood_mobile/Api/torrent_api.dart';
import 'package:flood_mobile/Pages/torrent_content_screen/widgets/folder_file_list_view.dart';
import 'package:flood_mobile/Pages/widgets/base_app_bar.dart';
import 'package:flood_mobile/Pages/widgets/toast_component.dart';
import 'package:flood_mobile/Route/Arguments/torrent_content_page_arguments.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';

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
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentContentScreenBloc, TorrentContentScreenState>(
      builder: (context, state) {
        final torrentContentBloc =
            BlocProvider.of<TorrentContentScreenBloc>(context);
        return Scaffold(
          appBar: (!state.isSelectionMode)
              ? BaseAppBar(
                  appBar: AppBar(),
                  themeIndex: widget.arguments.themeIndex,
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
                  backgroundColor:
                      ThemeBloc.theme(widget.arguments.themeIndex).primaryColor,
                  elevation: 0,
                  leading: Row(
                    children: [
                      Transform.rotate(
                        angle: 45 * math.pi / 180,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: ThemeBloc.theme(widget.arguments.themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                          ),
                          onPressed: () {
                            torrentContentBloc.add(
                                SetSelectionModeEvent(newIsSelected: false));
                            torrentContentBloc
                                .add(RemoveAllItemsFromListEvent());
                          },
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.download_rounded,
                        color: ThemeBloc.theme(widget.arguments.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                      ),
                      onPressed: () async {
                        try {
                          final status = await Permission.storage.request();
                          if (status.isGranted) {
                            String downloadFileIndexList = '';
                            for (int i in state.selectedIndexList) {
                              if (downloadFileIndexList != '') {
                                downloadFileIndexList += ',';
                              }
                              downloadFileIndexList += i.toString();
                            }
                            print(downloadFileIndexList);
                            final Directory? externalDir =
                                await getExternalStorageDirectory();
                            if (externalDir == null) {
                              Toasts.showFailToast(
                                  msg: context.l10n.toast_file_not_present);
                            } else {
                              FlutterDownloader.enqueue(
                                  url:
                                      "${BlocProvider.of<ApiBloc>(context, listen: false).state.baseUrl}/api/torrents/${widget.arguments.hash}/contents/$downloadFileIndexList/data",
                                  savedDir: externalDir.path,
                                  showNotification: true,
                                  openFileFromNotification: true,
                                  headers: {
                                    'Cookie': BlocProvider.of<UserDetailBloc>(
                                            context,
                                            listen: false)
                                        .token
                                  });
                            }
                          } else {
                            Toasts.showFailToast(
                                msg: context.l10n.toast_permission_denied);
                          }
                        } catch (error) {
                          print(error);
                        }
                      },
                    ),
                    PopupMenuButton<String>(
                      color: ThemeBloc.theme(widget.arguments.themeIndex)
                          .primaryColorLight,
                      icon: Icon(
                        Icons.more_vert,
                        color: ThemeBloc.theme(widget.arguments.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                      ),
                      onSelected: (value) {
                        if (value == context.l10n.torrent_high_priority) {
                          TorrentApi.setTorrentContentPriority(
                              context: context,
                              hash: widget.arguments.hash,
                              priorityType: 2,
                              indexList: state.selectedIndexList);
                          torrentContentBloc.add(RemoveAllItemsFromListEvent());
                          torrentContentBloc
                              .add(SetSelectionModeEvent(newIsSelected: false));
                        }
                        if (value == context.l10n.torrent_normal_priority) {
                          TorrentApi.setTorrentContentPriority(
                              context: context,
                              hash: widget.arguments.hash,
                              priorityType: 1,
                              indexList: state.selectedIndexList);
                          torrentContentBloc.add(RemoveAllItemsFromListEvent());
                          torrentContentBloc
                              .add(SetSelectionModeEvent(newIsSelected: false));
                        }
                        if (value == context.l10n.torrent_dont_download) {
                          TorrentApi.setTorrentContentPriority(
                              context: context,
                              hash: widget.arguments.hash,
                              priorityType: 0,
                              indexList: state.selectedIndexList);
                          torrentContentBloc.add(RemoveAllItemsFromListEvent());
                          torrentContentBloc
                              .add(SetSelectionModeEvent(newIsSelected: false));
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {
                          context.l10n.torrent_high_priority,
                          context.l10n.torrent_normal_priority,
                          context.l10n.torrent_dont_download,
                        }.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: TextStyle(
                                  color: ThemeBloc.theme(
                                          widget.arguments.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color),
                            ),
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
            color: ThemeBloc.theme(widget.arguments.themeIndex).primaryColor,
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
                            context.l10n.torrents_details_files,
                            style: GoogleFonts.notoSans(
                              color:
                                  ThemeBloc.theme(widget.arguments.themeIndex)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
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
                              Icon(
                                Icons.storage,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Text(
                                  widget.arguments.directory,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: ThemeBloc.theme(widget.arguments.themeIndex)
                                .primaryColorDark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        FolderFileListView(
                          data: snapshot.data,
                          depth: 0,
                          hash: widget.arguments.hash,
                          themeIndex: widget.arguments.themeIndex,
                        ),
                      ],
                    ),
                  );
                }
                return SpinKitFadingCircle(
                  color: ThemeBloc.theme(widget.arguments.themeIndex)
                      .primaryColorDark,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
