import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //Bandwidth Controller
  TextEditingController globalDownloadRateController =
      new TextEditingController();
  TextEditingController globalUploadRateController =
      new TextEditingController();
  TextEditingController uploadSlotPerTorrentController =
      new TextEditingController();
  TextEditingController uploadSlotGlobalController =
      new TextEditingController();
  TextEditingController downloadSlotPerTorrentController =
      new TextEditingController();
  TextEditingController downloadSlotGlobalController =
      new TextEditingController();

  //Connectivity Controller
  TextEditingController portRangeController = new TextEditingController();
  TextEditingController maxHttpConnectionsController =
      new TextEditingController();
  TextEditingController dhtPortController = new TextEditingController();
  TextEditingController maximumPeerController = new TextEditingController();
  TextEditingController minimumPeerController = new TextEditingController();
  TextEditingController maximumPeerSeedingController =
      new TextEditingController();
  TextEditingController minimumPeerSeedingController =
      new TextEditingController();
  TextEditingController peerDesiredController = new TextEditingController();
  bool randomizePort = false;
  bool openPort = false;
  bool enableDht = false;
  bool enablePeerExchange = false;

  //Resources Controller
  TextEditingController defaultDownloadDirectoryController =
      new TextEditingController();
  TextEditingController maximumOpenFilesController =
      new TextEditingController();
  TextEditingController maxMemoryUsageController = new TextEditingController();
  bool verifyHash = false;

  //Authentication
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController pathController = new TextEditingController();
  TextEditingController clientUsernameController = new TextEditingController();
  TextEditingController clientPasswordController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  bool isAdmin = false;
  bool socket = false;
  bool tcp = false;
  String client = 'rTorrent';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    ClientSettingsModel model =
        Provider.of<ClientSettingsProvider>(context).clientSettings;
    setState(() {
      //Bandwidth Initialization
      globalDownloadRateController = new TextEditingController(
          text: model.throttleGlobalDownSpeed.toString());
      globalUploadRateController = new TextEditingController(
          text: model.throttleGlobalUpSpeed.toString());
      uploadSlotPerTorrentController =
          new TextEditingController(text: model.throttleMaxUploads.toString());
      uploadSlotGlobalController = new TextEditingController(
          text: model.throttleMaxUploadsGlobal.toString());
      downloadSlotPerTorrentController = new TextEditingController(
          text: model.throttleMaxDownloads.toString());
      downloadSlotGlobalController = new TextEditingController(
          text: model.throttleMaxDownloadsGlobal.toString());

      //TODO Connectivity Initialization
      portRangeController =
          new TextEditingController(text: model.networkPortRange.toString());
      maxHttpConnectionsController =
          new TextEditingController(text: model.networkHttpMaxOpen.toString());
      dhtPortController =
          new TextEditingController(text: model.dhtPort.toString());
      minimumPeerController = new TextEditingController(
          text: model.throttleMinPeersNormal.toString());
      maximumPeerController = new TextEditingController(
          text: model.throttleMaxPeersNormal.toString());
      minimumPeerSeedingController = new TextEditingController(
          text: model.throttleMinPeersSeed.toString());
      maximumPeerSeedingController = new TextEditingController(
          text: model.throttleMaxPeersSeed.toString());
      peerDesiredController =
          new TextEditingController(text: model.trackersNumWant.toString());
      randomizePort = model.networkPortRandom;
      openPort = model.networkPortOpen;
      enableDht = model.dht;
      enablePeerExchange = model.protocolPex;

      //TODO Resources Initialization
      defaultDownloadDirectoryController =
          new TextEditingController(text: model.directoryDefault.toString());
      maximumOpenFilesController =
          new TextEditingController(text: model.networkMaxOpenFiles.toString());
      maxMemoryUsageController =
          new TextEditingController(text: model.piecesMemoryMax.toString());
      verifyHash = model.piecesHashOnCompletion;

      //TODO Authentication Initialization
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return Consumer<ClientSettingsProvider>(
        builder: (context, clientSettingsModel, child) {
      return KeyboardDismissOnTap(
        child: Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LText(text: 'Settings'),
                  //TODO:Bandwidth Section
                  SizedBox(height: 30),
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Bandwidth'),
                    leading: Icon(Icons.wifi_rounded),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Transfer Rate Throttles'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Global Download Rate Throttle',
                            labelText: 'Global Download Rate Throttle',
                            isText: false,
                            controller: globalDownloadRateController,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Global Upload Rate Throttle',
                            labelText: 'Global Upload Rate Throttle',
                            isText: false,
                            controller: globalUploadRateController,
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Slot Availability'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Upload Slots Per Torrent',
                            labelText: 'Upload Slots Per Torrent',
                            isText: false,
                            controller: uploadSlotPerTorrentController,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Upload Slots Global',
                            labelText: 'Upload Slots Global',
                            controller: uploadSlotGlobalController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Download Slots Per Torrent',
                            labelText: 'Download Slots Per Torrent',
                            controller: downloadSlotPerTorrentController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Download Slots Global',
                            labelText: 'Download Slots Global',
                            controller: downloadSlotGlobalController,
                            isText: false,
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Connectivity
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    leading: Icon(FontAwesomeIcons.connectdevelop),
                    title: MText(text: 'Connectivity'),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Incoming Connections'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Port Range',
                            labelText: 'Port Range',
                            isText: false,
                            controller: portRangeController,
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Randomize Port',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: clientSettingsModel
                                      .clientSettings.networkPortRandom,
                                  onChanged: (value) {
                                    setState(() {
                                      randomizePort = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Open Port',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: openPort,
                                  onChanged: (value) {
                                    setState(() {
                                      openPort = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum HTTP Connections',
                            labelText: 'Maximum HTTP Connections',
                            isText: false,
                            controller: maxHttpConnectionsController,
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Decentralized Peer Discovery'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'DHT Port',
                            labelText: 'DHT Port',
                            controller: dhtPortController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Enable DHT',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: enableDht,
                                  onChanged: (value) {
                                    setState(() {
                                      enableDht = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Enable Peer Exchange',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: enablePeerExchange,
                                  onChanged: (value) {
                                    setState(() {
                                      enablePeerExchange = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Peers'),
                          SizedBox(height: 15),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Minimum Peers',
                            labelText: 'Minimum Peers',
                            controller: minimumPeerController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum Peers',
                            labelText: 'Maximum Peers',
                            controller: maximumPeerController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Minimum Peers Seeding',
                            labelText: 'Minimum Peers Seeding',
                            controller: minimumPeerSeedingController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Maximum Peers Seeding',
                            labelText: 'Maximum Peers Seeding',
                            controller: maximumPeerSeedingController,
                            isText: false,
                          ),
                          SizedBox(height: 22),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Peers Desired',
                            labelText: 'Peers Desired',
                            controller: peerDesiredController,
                            isText: false,
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Resources
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Resources'),
                    leading: Icon(Icons.settings),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Disk'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Default Download Directory',
                            labelText: 'Default Download Directory',
                            controller: defaultDownloadDirectoryController,
                          ),
                          SizedBox(height: 22),
                          Row(
                            children: [
                              Expanded(
                                child: SettingsTextField(
                                  validator: (value) {},
                                  hintText: 'Maximum Open Files',
                                  labelText: 'Maximum Open Files',
                                  controller: maximumOpenFilesController,
                                  isText: false,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(''),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    CheckboxListTile(
                                      activeColor: AppColor.greenAccentColor,
                                      tileColor: AppColor.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      title: Text(
                                        'Verify Hash',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      value: clientSettingsModel.clientSettings
                                          .piecesHashOnCompletion,
                                      onChanged: (value) {
                                        setState(() {
                                          verifyHash = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          SText(text: 'Memory'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Max Memory Usage (MB)',
                            labelText: 'Max Memory Usage (MB)',
                            controller: maxMemoryUsageController,
                            isText: false,
                          ),
                        ],
                      )
                    ],
                  ),
                  //TODO Authentication
                  ExpansionTileCard(
                    onExpansionChanged: (value) {},
                    elevation: 0,
                    expandedColor: AppColor.primaryColor,
                    baseColor: AppColor.primaryColor,
                    title: MText(text: 'Authentication'),
                    leading: Icon(Icons.security),
                    contentPadding: EdgeInsets.all(0),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(text: 'Add User'),
                          SizedBox(height: 25),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Username',
                            labelText: 'Username',
                            controller: usernameController,
                          ),
                          SizedBox(height: 20),
                          SettingsTextField(
                            validator: (value) {},
                            hintText: 'Password',
                            labelText: 'Password',
                            controller: passwordController,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  activeColor: AppColor.greenAccentColor,
                                  tileColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Is Admin',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: isAdmin,
                                  onChanged: (value) {
                                    setState(() {
                                      isAdmin = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColor.secondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: client,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded),
                                      dropdownColor: AppColor.secondaryColor,
                                      elevation: 16,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          client = newValue;
                                        });
                                      },
                                      underline: Container(),
                                      items: <String>[
                                        'rTorrent',
                                        'qBittorrent',
                                        'Transmission',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          //Check if the client is rTorrent, qBittorrent or Transmission

                          (client == 'rTorrent')
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CheckboxListTile(
                                            tileColor: AppColor.secondaryColor,
                                            activeColor:
                                                AppColor.greenAccentColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            title: Text(
                                              'Socket',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            value: socket,
                                            onChanged: (value) {
                                              setState(() {
                                                socket = value;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: CheckboxListTile(
                                            activeColor:
                                                AppColor.greenAccentColor,
                                            tileColor: AppColor.secondaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            title: Text(
                                              'TCP',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            value: tcp,
                                            onChanged: (value) {
                                              setState(() {
                                                tcp = value;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    SettingsTextField(
                                      validator: (value) {},
                                      hintText: 'eg. ~/.local/share/rtorrent',
                                      labelText: 'Path',
                                      controller: pathController,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    SettingsTextField(
                                      validator: (value) {},
                                      hintText: 'Client Username',
                                      labelText: 'Username',
                                      controller: clientUsernameController,
                                    ),
                                    SizedBox(height: 20),
                                    SettingsTextField(
                                      validator: (value) {},
                                      hintText: 'Client Password',
                                      labelText: 'Password',
                                      controller: clientPasswordController,
                                    ),
                                    SizedBox(height: 20),
                                    SettingsTextField(
                                      validator: (value) {},
                                      hintText: 'eg. http://localhost:8080/',
                                      labelText: 'URL',
                                      controller: urlController,
                                    ),
                                  ],
                                ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                child: Container(
                                  height: hp * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // AuthApi.registerUser(
                                      //   context: context,
                                      //   model: RegisterUserModel(
                                      //       username: 'te',
                                      //       password: 'te',
                                      //       client: "qBittorrent",
                                      //       type: "web",
                                      //       version: 1,
                                      //       url: "http://localhost:8080",
                                      //       clientUsername: "admin",
                                      //       clientPassword: "adminPass",
                                      //       level: 10),
                                      // );
                                    },
                                    // {
                                    //   "username": "te",
                                    //   "password": "te",
                                    //   "client": {
                                    //     "client": "qBittorrent",
                                    //     "type": "web",
                                    //     "version": 1,
                                    //     "url": "http://localhost:8080/",
                                    //     "username": "admin",
                                    //     "password": "admin"
                                    //   },
                                    //   "level": 5
                                    // }
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      primary: AppColor.blueAccentColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
