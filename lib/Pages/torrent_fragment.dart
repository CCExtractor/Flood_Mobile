import 'package:flood_mobile/Components/add_torrent_sheet.dart';
import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_reveal/pull_to_reveal.dart';

class TorrentScreen extends StatefulWidget {
  @override
  _TorrentScreenState createState() => _TorrentScreenState();
}

class _TorrentScreenState extends State<TorrentScreen> {
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(
      builder: (context, model, child) {
        return Consumer<ClientProvider>(builder: (context, clientModel, child) {
          return KeyboardDismissOnTap(
            child: Scaffold(
              body: Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColor.primaryColor,
                child: (model.torrentList.length != 0)
                    ? PullToRevealTopItemList(
                        itemCount: model.torrentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (model.torrentList[index].name
                              .toLowerCase()
                              .contains(keyword.toLowerCase())) {
                            return TorrentTile(model: model.torrentList[index]);
                          }
                          return Container();
                        },
                        revealableHeight: 165,
                        revealableBuilder: (BuildContext context,
                            RevealableToggler opener,
                            RevealableToggler closer,
                            BoxConstraints constraints) {
                          return Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: wp * 0.15,
                                      left: wp * 0.15,
                                      top: hp * 0.01,
                                      bottom: hp * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward_rounded,
                                            color: AppColor.greenAccentColor,
                                            size: wp * 0.07,
                                          ),
                                          Text(
                                            model.upSpeed,
                                            style: TextStyle(
                                              color: AppColor.greenAccentColor,
                                              fontSize: wp * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_downward_rounded,
                                            color: AppColor.blueAccentColor,
                                            size: wp * 0.07,
                                          ),
                                          Text(
                                            model.downSpeed,
                                            style: TextStyle(
                                              color: AppColor.blueAccentColor,
                                              fontSize: wp * 0.045,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      left: wp * 0.05, right: wp * 0.05),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        keyword = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      hintText: 'Search Torrent',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: SvgPicture.asset(
                          'assets/images/empty_dark.svg',
                          width: 120,
                          height: 120,
                        ),
                      ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: AppColor.secondaryColor,
                      builder: (context) {
                        return AddTorrentSheet(
                            clientSettings: clientModel.clientSettings);
                      });
                },
                backgroundColor: AppColor.greenAccentColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
