import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/authentication_section.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/bandwidth_section.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/connectivity_section.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/resource_section.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/speed_limit_section.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SettingsScreen extends StatefulWidget {
  final int themeIndex;

  const SettingsScreen({Key? key, required this.themeIndex}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // *Bandwidth Controller
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

  // *Connectivity Controller
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

  // *Resources Controller
  TextEditingController defaultDownloadDirectoryController =
      new TextEditingController();
  TextEditingController maximumOpenFilesController =
      new TextEditingController();
  TextEditingController maxMemoryUsageController = new TextEditingController();
  bool verifyHash = false;

  // *Speed Limit
  String upSpeed = '1 kB/s';
  String downSpeed = '1 kB/s';

  // *Authentication
  String currentUsername = '';
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController pathController = new TextEditingController();
  TextEditingController clientUsernameController = new TextEditingController();
  TextEditingController clientPasswordController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  TextEditingController hostController = new TextEditingController();
  TextEditingController portController = new TextEditingController();
  bool isAdmin = false;
  bool socket = true;
  String client = 'rTorrent';
  GlobalKey<FormState> _authenticationformKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    ClientSettingsModel model =
        BlocProvider.of<ClientSettingsBloc>(context).clientSettings;
    setState(() {
      // *Bandwidth Initialization
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

      // *Connectivity Initialization
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

      // *Resources Initialization
      defaultDownloadDirectoryController =
          new TextEditingController(text: model.directoryDefault.toString());
      maximumOpenFilesController =
          new TextEditingController(text: model.networkMaxOpenFiles.toString());
      maxMemoryUsageController =
          new TextEditingController(text: model.piecesMemoryMax.toString());
      verifyHash = model.piecesHashOnCompletion;

      // *Speed Limit Initialization
      downSpeed =
          TransferSpeedManager.valToSpeedMap[model.throttleGlobalDownSpeed] ??
              'Unlimited';
      upSpeed =
          TransferSpeedManager.valToSpeedMap[model.throttleGlobalUpSpeed] ??
              'Unlimited';

      // Authentication Initialization

      currentUsername =
          BlocProvider.of<UserDetailBloc>(context, listen: false).username;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    return KeyboardDismissOnTap(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
          onPressed: () {
            ClientSettingsModel clientSettingsModel =
                BlocProvider.of<ClientSettingsBloc>(context).clientSettings;
            ClientSettingsModel newClientSettingsModel =
                new ClientSettingsModel(
                    dht: clientSettingsModel.dht,
                    dhtPort: clientSettingsModel.dhtPort,
                    directoryDefault: defaultDownloadDirectoryController.text,
                    networkHttpMaxOpen: clientSettingsModel.networkHttpMaxOpen,
                    networkLocalAddress: clientSettingsModel
                        .networkLocalAddress,
                    networkMaxOpenFiles: clientSettingsModel
                        .networkMaxOpenFiles,
                    networkPortOpen: openPort,
                    networkPortRandom: randomizePort,
                    networkPortRange: portController.text,
                    piecesHashOnCompletion: clientSettingsModel
                        .piecesHashOnCompletion,
                    piecesMemoryMax: clientSettingsModel.piecesMemoryMax,
                    protocolPex: clientSettingsModel.protocolPex,
                    throttleGlobalDownSpeed: int.parse(
                        globalDownloadRateController.text),
                    throttleGlobalUpSpeed: int.parse(globalUploadRateController
                        .text),
                    throttleMaxDownloads: int
                        .parse(downloadSlotPerTorrentController.text),
                    throttleMaxDownloadsGlobal: int
                        .parse(downloadSlotGlobalController.text),
                    throttleMaxPeersNormal:
                        clientSettingsModel.throttleMaxPeersNormal,
                    throttleMaxPeersSeed:
                        clientSettingsModel.throttleMaxPeersSeed,
                    throttleMaxUploads: int
                        .parse(uploadSlotPerTorrentController.text),
                    throttleMaxUploadsGlobal: int
                        .parse(uploadSlotGlobalController.text),
                    throttleMinPeersNormal:
                        clientSettingsModel.throttleMinPeersNormal,
                    throttleMinPeersSeed:
                        clientSettingsModel.throttleMinPeersSeed,
                    trackersNumWant: clientSettingsModel.trackersNumWant);
            ClientApi.setClientSettings(
                    context: context, model: newClientSettingsModel)
                .then((value) {
              setState(() {});
            });

            final changeSettingsSnackBar = addFloodSnackBar(
                SnackbarType.success, 'Settings changed', 'Dismiss');

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(changeSettingsSnackBar);
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            "Save",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LText(text: 'Settings'),
                SizedBox(height: 30),
                // *Bandwidth Section
                BandwidthSection(
                  globalDownloadRateController: globalDownloadRateController,
                  globalUploadRateController: globalUploadRateController,
                  uploadSlotPerTorrentController:
                      uploadSlotPerTorrentController,
                  uploadSlotGlobalController: uploadSlotGlobalController,
                  downloadSlotPerTorrentController:
                      downloadSlotPerTorrentController,
                  downloadSlotGlobalController: downloadSlotGlobalController,
                  themeIndex: widget.themeIndex,
                ),
                // *Connectivity Section
                ConnectivitySection(
                  clientSettingsBloc:
                      BlocProvider.of<ClientSettingsBloc>(context),
                  portRangeController: portRangeController,
                  openPort: openPort,
                  maxHttpConnectionsController: maxHttpConnectionsController,
                  dhtPortController: dhtPortController,
                  enableDht: enableDht,
                  enablePeerExchange: enablePeerExchange,
                  minimumPeerController: minimumPeerController,
                  maximumPeerController: maximumPeerController,
                  minimumPeerSeedingController: minimumPeerSeedingController,
                  maximumPeerSeedingController: maximumPeerSeedingController,
                  peerDesiredController: peerDesiredController,
                  randomizePort: randomizePort,
                  setRandomizePort: (value) {
                    setState(() {
                      randomizePort = value!;
                    });
                  },
                  setEnableDht: null,
                  setEnablePeerExchange: null,
                  setOpenPort: (value) {
                    setState(() {
                      openPort = value!;
                    });
                  },
                  themeIndex: widget.themeIndex,
                ),
                // *Resources Section
                ResourceSection(
                  setVerifyHash: (value) {
                    setState(() {
                      verifyHash = value!;
                    });
                  },
                  defaultDownloadDirectoryController:
                      defaultDownloadDirectoryController,
                  maximumOpenFilesController: maximumOpenFilesController,
                  verifyHash: verifyHash,
                  maxMemoryUsageController: maxMemoryUsageController,
                  themeIndex: widget.themeIndex,
                ),
                // *Speed Limit Section
                SpeedLimitSection(
                  bloc: BlocProvider.of<ClientSettingsBloc>(context),
                  hp: hp,
                  downSpeed: downSpeed,
                  upSpeed: upSpeed,
                  setDownSpeed: (value) {
                    setState(() {
                      downSpeed = value!;
                    });
                  },
                  setUpSpeed: (value) {
                    setState(() {
                      upSpeed = value!;
                    });
                  },
                  themeIndex: widget.themeIndex,
                ),
                // *Authentication Section
                AuthenticationSection(
                  setTCP: (value) {
                    setState(() {
                      socket = !value!;
                    });
                  },
                  setSocket: (bool? value) {
                    setState(() {
                      socket = value!;
                    });
                  },
                  setClient: (String? newValue) {
                    setState(() {
                      client = newValue!;
                    });
                  },
                  setIsAdmin: (bool? value) {
                    setState(() {
                      isAdmin = value!;
                    });
                  },
                  usernameController: usernameController,
                  passwordController: passwordController,
                  isAdmin: isAdmin,
                  client: client,
                  socket: socket,
                  pathController: pathController,
                  hostController: hostController,
                  portController: portController,
                  clientUsernameController: clientUsernameController,
                  clientPasswordController: clientPasswordController,
                  urlController: urlController,
                  hp: hp,
                  authenticationformKey: _authenticationformKey,
                  themeIndex: widget.themeIndex,
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
  }
}
