import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
        return KeyboardDismissOnTap(
          child: Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColor.primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: wp * 0.15,
                        left: wp * 0.15,
                        top: hp * 0.01,
                        bottom: hp * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: wp * 0.05,
                        right: wp * 0.05,
                        top: hp * 0.01,
                        bottom: hp * 0.02),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          keyword = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Torrent',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: (model.torrentList.length != 0)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.torrentList.length,
                            itemBuilder: (context, index) {
                              if (model.torrentList[index].name
                                  .toLowerCase()
                                  .contains(keyword.toLowerCase())) {
                                return TorrentTile(
                                    model: model.torrentList[index]);
                              }
                              return Container();
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
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   backgroundColor: Colors.transparent,
                //   builder: (context) {
                //     return GestureDetector(
                //       onTap: () => Navigator.of(context).pop(),
                //       child: Container(
                //         color: Color.fromRGBO(0, 0, 0, 0.001),
                //         child: GestureDetector(
                //           onTap: () {},
                //           child: DraggableScrollableSheet(
                //             initialChildSize: 0.4,
                //             minChildSize: 0.2,
                //             maxChildSize: 0.75,
                //             builder: (_, controller) {
                //               return Container(
                //                 decoration: BoxDecoration(
                //                   color: AppColor.secondaryColor,
                //                   borderRadius: BorderRadius.only(
                //                     topLeft: const Radius.circular(25.0),
                //                     topRight: const Radius.circular(25.0),
                //                   ),
                //                 ),
                //                 child: ListView.builder(
                //                   controller: controller,
                //                   itemCount: 100,
                //                   itemBuilder: (_, index) {
                //                     return ListTile(
                //                       leading: Icon(Icons.ac_unit),
                //                       title: Text('Cooling'),
                //                       onTap: () => _selectItem('Cooling'),
                //                     );
                //                   },
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
              backgroundColor: AppColor.greenAccentColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Cooling'),
          onTap: () => _selectItem('Cooling'),
        ),
        ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text('People'),
          onTap: () => _selectItem('People'),
        ),
        ListTile(
          leading: Icon(Icons.assessment),
          title: Text('Stats'),
          onTap: () => _selectItem('Stats'),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
  }
}
