import 'package:flood_mobile/Components/torrent_tile.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
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
                    // ListView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: model.torrentList.length,
                    //         itemBuilder: (context, index) {
                    //           if (model.torrentList[index].name
                    //               .toLowerCase()
                    //               .contains(keyword.toLowerCase())) {
                    //             return TorrentTile(
                    //                 model: model.torrentList[index]);
                    //           }
                    //           return Container();
                    //         },
                    //       )
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
                      context: context,
                      backgroundColor: Color(0xff07111A),
                      builder: (context) {
                        return Container(
                          color: Color(0xff07111A),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 40),
                            child: _buildBottomNavigationMenu(
                                clientModel.clientSettings),
                            decoration: BoxDecoration(
                              color: AppColor.secondaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10),
                                topRight: const Radius.circular(10),
                              ),
                            ),
                          ),
                        );
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

  Padding _buildBottomNavigationMenu(ClientSettingsModel model) {
    TextEditingController directoryController =
        new TextEditingController(text: model.directoryDefault);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: directoryController,
              style: TextStyle(
                color: AppColor.textColor,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
                labelText: 'Destination',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: AppColor.greenAccentColor,
                //   ),
                // ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // disabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.white,
                //   ),
                // ),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.white,
                //   ),
                // ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field cannot be empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () async {
                // if (_formKey.currentState.validate()) {
                //   Provider.of<ApiProvider>(context, listen: false)
                //       .setBaseUrl(urlController.text);
                //   setState(() {
                //     showSpinner = true;
                //   });
                //   bool isLoginSuccessful = await AuthApi.loginUser(
                //       username: usernameController.text,
                //       password: passwordController.text,
                //       context: context);
                //   if (isLoginSuccessful) {
                //     Toasts.showSuccessToast(
                //         msg: 'Login Successful');
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //         Routes.homeScreenRoute,
                //             (Route<dynamic> route) => false);
                //   } else {
                //     Toasts.showFailToast(msg: 'Login Error');
                //   }
                //   setState(() {
                //     showSpinner = false;
                //   });
                // }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                primary: AppColor.greenAccentColor,
              ),
              child: Center(
                child: Text(
                  "Add Torrent",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
  }
}
