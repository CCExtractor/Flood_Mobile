import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Components/flood_snackbar.dart';
import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Components/user_list.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';
import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final int index;

  const SettingsScreen({Key? key, required this.index}) : super(key: key);
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
  List<CurrentUserDetailModel> usersList = [];
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
        Provider.of<ClientSettingsProvider>(context).clientSettings;
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
      usersList = Provider.of<UserDetailProvider>(context).usersList;
      currentUsername =
          Provider.of<UserDetailProvider>(context, listen: false).username;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    return Consumer<ClientSettingsProvider>(
        builder: (context, clientSettingsModel, child) {
      return KeyboardDismissOnTap(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: ThemeProvider.theme(widget.index).primaryColorDark,
            onPressed: () {
              ClientSettingsModel newClientSettingsModel = new ClientSettingsModel(
                  dht: clientSettingsModel.clientSettings.dht,
                  dhtPort: clientSettingsModel.clientSettings.dhtPort,
                  directoryDefault: defaultDownloadDirectoryController.text,
                  networkHttpMaxOpen:
                      clientSettingsModel.clientSettings.networkHttpMaxOpen,
                  networkLocalAddress:
                      clientSettingsModel.clientSettings.networkLocalAddress,
                  networkMaxOpenFiles:
                      clientSettingsModel.clientSettings.networkMaxOpenFiles,
                  networkPortOpen: openPort,
                  networkPortRandom: randomizePort,
                  networkPortRange: portController.text,
                  piecesHashOnCompletion:
                      clientSettingsModel.clientSettings.piecesHashOnCompletion,
                  piecesMemoryMax:
                      clientSettingsModel.clientSettings.piecesMemoryMax,
                  protocolPex: clientSettingsModel.clientSettings.protocolPex,
                  throttleGlobalDownSpeed:
                      int.parse(globalDownloadRateController.text),
                  throttleGlobalUpSpeed:
                      int.parse(globalUploadRateController.text),
                  throttleMaxDownloads:
                      int.parse(downloadSlotPerTorrentController.text),
                  throttleMaxDownloadsGlobal:
                      int.parse(downloadSlotGlobalController.text),
                  throttleMaxPeersNormal:
                      clientSettingsModel.clientSettings.throttleMaxPeersNormal,
                  throttleMaxPeersSeed:
                      clientSettingsModel.clientSettings.throttleMaxPeersSeed,
                  throttleMaxUploads:
                      int.parse(uploadSlotPerTorrentController.text),
                  throttleMaxUploadsGlobal:
                      int.parse(uploadSlotGlobalController.text),
                  throttleMinPeersNormal:
                      clientSettingsModel.clientSettings.throttleMinPeersNormal,
                  throttleMinPeersSeed:
                      clientSettingsModel.clientSettings.throttleMinPeersSeed,
                  trackersNumWant:
                      clientSettingsModel.clientSettings.trackersNumWant);
              ClientApi.setClientSettings(
                      context: context, model: newClientSettingsModel)
                  .then((value) {
                setState(() {});
              });

              final changeSettingsSnackBar = addFloodSnackBar(
                  SnackbarType.success, 'Settings changed', 'Dismiss');

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context)
                  .showSnackBar(changeSettingsSnackBar);
            },
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              "Save",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: ThemeProvider.theme(widget.index).primaryColor,
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
                    index: widget.index,
                  ),
                  // *Connectivity Section
                  ConnectivitySection(
                    clientSettingsModel: clientSettingsModel,
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
                    index: widget.index,
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
                    index: widget.index,
                  ),
                  // *Speed Limit Section
                  SpeedLimitSection(
                    model: clientSettingsModel,
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
                    index: widget.index,
                  ),
                  // *Authentication Section
                  AuthenticationSection(
                    usersList: usersList,
                    currentUsername: currentUsername,
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
                    index: widget.index,
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

class SpeedLimitSection extends StatelessWidget {
  SpeedLimitSection(
      {Key? key,
      required this.hp,
      required this.downSpeed,
      required this.setDownSpeed,
      required this.setUpSpeed,
      required this.upSpeed,
      required this.model,
      required this.index})
      : super(key: key);

  final double hp;
  final String upSpeed;
  final String downSpeed;
  final void Function(String? value) setUpSpeed;
  final void Function(String? value) setDownSpeed;
  final ClientSettingsProvider model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: Key('Speed Limit Expansion Card'),
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme(index).primaryColor,
      baseColor: ThemeProvider.theme(index).primaryColor,
      expandedTextColor: ThemeProvider.theme(index).colorScheme.secondary,
      title: MText(text: 'Speed Limit'),
      leading: Icon(Icons.speed_rounded),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Speed Limit options column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
            ),
            SText(text: 'Download', index: index),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ThemeProvider.theme(index).primaryColorLight,
                      border: null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        key: Key('Download Speed Dropdown'),
                        dropdownColor:
                            ThemeProvider.theme(index).primaryColorLight,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: ThemeProvider.theme(index)
                              .textTheme
                              .bodyLarge
                              ?.color,
                          size: 25,
                        ),
                        hint: Text("Download Speed"),
                        items: TransferSpeedManager.speedToValMap.keys
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                  ),
                                ))
                            .toList(),
                        onChanged: setDownSpeed,
                        value: TransferSpeedManager.valToSpeedMap[
                                model.clientSettings.throttleGlobalDownSpeed] ??
                            'Unlimited',
                      ),
                    )),
              ],
            ),
            SizedBox(height: 25),
            SText(text: 'Upload', index: index),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ThemeProvider.theme(index).primaryColorLight,
                      border: null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        key: Key('Upload Speed Dropdown'),
                        dropdownColor:
                            ThemeProvider.theme(index).colorScheme.background,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: ThemeProvider.theme(index)
                              .textTheme
                              .bodyLarge
                              ?.color,
                          size: 25,
                        ),
                        hint: Text("Upload Speed"),
                        items: TransferSpeedManager.speedToValMap.keys
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                  ),
                                ))
                            .toList(),
                        onChanged: setUpSpeed,
                        value: TransferSpeedManager.valToSpeedMap[
                                model.clientSettings.throttleGlobalUpSpeed] ??
                            'Unlimited',
                      ),
                    )),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: Container(
                    height: hp * 0.06,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ElevatedButton(
                      onPressed: () {
                        ClientApi.setSpeedLimit(
                            context: context,
                            downSpeed: downSpeed,
                            upSpeed: upSpeed);
                        final setSpeedSnackbar = addFloodSnackBar(
                            SnackbarType.information,
                            'Speed set successfully',
                            'Dismiss');
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(setSpeedSnackbar);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor:
                            ThemeProvider.theme(index).colorScheme.secondary,
                      ),
                      child: Center(
                        child: Text(
                          "Set",
                          style: TextStyle(
                              color: ThemeProvider.theme(index)
                                  .textTheme
                                  .bodyLarge
                                  ?.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        )
      ],
    );
  }
}

class AuthenticationSection extends StatelessWidget {
  AuthenticationSection({
    Key? key,
    required this.usersList,
    required this.currentUsername,
    required this.usernameController,
    required this.passwordController,
    required this.isAdmin,
    required this.client,
    required this.socket,
    required this.pathController,
    required this.hostController,
    required this.portController,
    required this.clientUsernameController,
    required this.clientPasswordController,
    required this.urlController,
    required this.hp,
    required this.setClient,
    required this.setIsAdmin,
    required this.setSocket,
    required this.setTCP,
    required this.authenticationformKey,
    required this.index,
  }) : super(key: key);

  final List<CurrentUserDetailModel> usersList;
  final String currentUsername;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isAdmin;
  final String client;
  final bool socket;
  final TextEditingController pathController;
  final TextEditingController hostController;
  final TextEditingController portController;
  final TextEditingController clientUsernameController;
  final TextEditingController clientPasswordController;
  final TextEditingController urlController;
  final double hp;
  final void Function(bool? value) setIsAdmin;
  final void Function(String? value) setClient;
  final void Function(bool? value) setSocket;
  final void Function(bool? value) setTCP;
  final GlobalKey<FormState> authenticationformKey;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (usersList.length == 0) {
      // User is not Admin
      return ExpansionTileCard(
        key: Key('Authentication Expansion Card'),
        onExpansionChanged: (value) {},
        elevation: 0,
        expandedColor: ThemeProvider.theme(index).primaryColor,
        baseColor: ThemeProvider.theme(index).primaryColor,
        title: MText(text: 'Authentication'),
        leading: Icon(Icons.security),
        contentPadding: EdgeInsets.all(0),
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeProvider.theme(index).colorScheme.error,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ThemeProvider.theme(index).primaryColor,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("User is not Admin"),
            ),
          ),
        ],
      );
    }
    return ExpansionTileCard(
      key: Key('Authentication Expansion Card'),
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme(index).primaryColor,
      baseColor: ThemeProvider.theme(index).primaryColor,
      expandedTextColor: ThemeProvider.theme(index).colorScheme.secondary,
      title: MText(text: 'Authentication'),
      leading: Icon(Icons.security),
      contentPadding: EdgeInsets.all(0),
      children: [
        Form(
          key: authenticationformKey,
          child: Column(
            key: Key('Authentication option display column'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SText(text: 'User Accounts', index: index),
              SizedBox(height: 25),
              UsersListView(
                usersList: usersList,
                currentUsername: currentUsername,
                index: index,
              ),
              SizedBox(height: 25),
              SText(text: 'Add User', index: index),
              SizedBox(height: 25),
              SettingsTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username cannot be empty.";
                  }
                  return null;
                },
                hintText: 'Username',
                labelText: 'Username',
                controller: usernameController,
                index: index,
              ),
              SizedBox(height: 20),
              SettingsTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty.";
                  }
                  return null;
                },
                hintText: 'Password',
                labelText: 'Password',
                controller: passwordController,
                index: index,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      activeColor: ThemeProvider.theme(index).primaryColorDark,
                      tileColor: ThemeProvider.theme(index).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(
                        'Is Admin',
                        style: TextStyle(fontSize: 12),
                      ),
                      value: isAdmin,
                      onChanged: setIsAdmin,
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
                        color: ThemeProvider.theme(index).primaryColorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          key: Key('Authentication dropdown'),
                          isExpanded: true,
                          value: client,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          dropdownColor:
                              ThemeProvider.theme(index).primaryColorLight,
                          elevation: 16,
                          onChanged: setClient,
                          underline: Container(),
                          items: <String>[
                            'rTorrent',
                            'qBittorrent',
                            'Transmission',
                          ].map<DropdownMenuItem<String>>((String value) {
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
                                  tileColor: ThemeProvider.theme(index)
                                      .primaryColorLight,
                                  activeColor: ThemeProvider.theme(index)
                                      .primaryColorDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  title: Text(
                                    'Socket',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  value: socket,
                                  onChanged: setSocket),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                activeColor:
                                    ThemeProvider.theme(index).primaryColorDark,
                                tileColor: ThemeProvider.theme(index)
                                    .primaryColorLight,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                title: Text(
                                  'TCP',
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: !socket,
                                onChanged: setTCP,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        (socket)
                            ? SettingsTextField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Path cannot be empty";
                                  }
                                  return null;
                                },
                                hintText: 'eg. ~/.local/share/rtorrent',
                                labelText: 'Path',
                                controller: pathController,
                                index: index,
                              )
                            : Column(
                                children: [
                                  SettingsTextField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Host or IP cannot be empty";
                                      }
                                      return null;
                                    },
                                    hintText: 'Host or IP',
                                    labelText: 'Host',
                                    controller: hostController,
                                    index: index,
                                  ),
                                  SizedBox(height: 20),
                                  SettingsTextField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Port cannot be empty";
                                      }
                                      return null;
                                    },
                                    hintText: 'Port',
                                    labelText: 'Port',
                                    controller: portController,
                                    index: index,
                                  )
                                ],
                              ),
                      ],
                    )
                  : Column(
                      children: [
                        SettingsTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Client Username cannot be empty.";
                            }
                            return null;
                          },
                          hintText: 'Client Username',
                          labelText: 'Username',
                          controller: clientUsernameController,
                          index: index,
                        ),
                        SizedBox(height: 20),
                        SettingsTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Client Password cannot be empty.";
                            }
                            return null;
                          },
                          hintText: 'Client Password',
                          labelText: 'Password',
                          controller: clientPasswordController,
                          index: index,
                        ),
                        SizedBox(height: 20),
                        SettingsTextField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "URL cannot be empty";
                            } else if (!value.startsWith("http://")) {
                              return "Enter valid URL";
                            }
                            return null;
                          },
                          hintText: client == "qBittorrent"
                              ? 'eg. http://localhost:8080'
                              : 'eg. http://localhost:9091/transmission/rpc',
                          labelText: 'URL',
                          controller: urlController,
                          index: index,
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (authenticationformKey.currentState!.validate()) {
                            AuthApi.registerUser(
                              context: context,
                              model: RegisterUserModel(
                                username: usernameController.text,
                                password: passwordController.text,
                                client: client,
                                type: (client == 'rTorrent')
                                    ? (socket)
                                        ? 'socket'
                                        : 'tcp'
                                    : "web",
                                version: 1,
                                url: urlController.text,
                                clientUsername: clientUsernameController.text,
                                clientPassword: clientPasswordController.text,
                                level: isAdmin ? 10 : 5,
                                path: pathController.text,
                                host: hostController.text,
                                port: int.parse(
                                  portController.text.isEmpty
                                      ? "0"
                                      : portController.text,
                                ),
                              ),
                            );
                            AuthApi.getUsersList(context);
                            usernameController.clear();
                            passwordController.clear();
                            pathController.clear();
                            clientUsernameController.clear();
                            clientPasswordController.clear();
                            urlController.clear();
                            hostController.clear();
                            portController.clear();
                            setIsAdmin(false);
                            setSocket(true);
                            setClient('rTorrent');

                            final addNewUserSnackBar = addFloodSnackBar(
                                SnackbarType.success,
                                'New user added',
                                'Dismiss');

                            ScaffoldMessenger.of(context)
                                .showSnackBar(addNewUserSnackBar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor:
                              ThemeProvider.theme(index).colorScheme.secondary,
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ResourceSection extends StatelessWidget {
  const ResourceSection({
    Key? key,
    required this.defaultDownloadDirectoryController,
    required this.maximumOpenFilesController,
    required this.verifyHash,
    required this.maxMemoryUsageController,
    required this.setVerifyHash,
    required this.index,
  }) : super(key: key);

  final TextEditingController defaultDownloadDirectoryController;
  final TextEditingController maximumOpenFilesController;
  final bool verifyHash;
  final TextEditingController maxMemoryUsageController;
  final void Function(bool? value) setVerifyHash;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: Key('Resources Expansion Card'),
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme(index).primaryColor,
      expandedTextColor: ThemeProvider.theme(index).colorScheme.secondary,
      baseColor: ThemeProvider.theme(index).primaryColor,
      title: MText(text: 'Resources'),
      leading: Icon(Icons.settings),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Resources options display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(text: 'Disk', index: index),
            SizedBox(height: 25),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Default Download Directory',
              labelText: 'Default Download Directory',
              controller: defaultDownloadDirectoryController,
              index: index,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: SettingsTextField(
                    validator: (value) {
                      return null;
                    },
                    hintText: 'Maximum Open Files',
                    labelText: 'Maximum Open Files',
                    controller: maximumOpenFilesController,
                    isText: false,
                    index: index,
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
                        key: Key('Verify Hash checkbox'),
                        activeColor:
                            ThemeProvider.theme(index).colorScheme.background,
                        tileColor: ThemeProvider.theme(index).primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Text(
                          'Verify Hash',
                          style: TextStyle(fontSize: 12),
                        ),
                        value: verifyHash,
                        onChanged: setVerifyHash,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            SText(text: 'Memory', index: index),
            SizedBox(height: 25),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Max Memory Usage (MB)',
              labelText: 'Max Memory Usage (MB)',
              controller: maxMemoryUsageController,
              isText: false,
              index: index,
            ),
          ],
        )
      ],
    );
  }
}

class ConnectivitySection extends StatelessWidget {
  const ConnectivitySection(
      {Key? key,
      required this.portRangeController,
      required this.openPort,
      required this.maxHttpConnectionsController,
      required this.dhtPortController,
      required this.enableDht,
      required this.enablePeerExchange,
      required this.minimumPeerController,
      required this.maximumPeerController,
      required this.minimumPeerSeedingController,
      required this.maximumPeerSeedingController,
      required this.peerDesiredController,
      required this.clientSettingsModel,
      required this.setEnableDht,
      required this.setEnablePeerExchange,
      required this.setOpenPort,
      required this.setRandomizePort,
      required this.randomizePort,
      required this.index})
      : super(key: key);

  final TextEditingController portRangeController;
  final bool openPort;
  final bool randomizePort;
  final TextEditingController maxHttpConnectionsController;
  final TextEditingController dhtPortController;
  final bool enableDht;
  final bool enablePeerExchange;
  final TextEditingController minimumPeerController;
  final TextEditingController maximumPeerController;
  final TextEditingController minimumPeerSeedingController;
  final TextEditingController maximumPeerSeedingController;
  final TextEditingController peerDesiredController;
  final ClientSettingsProvider clientSettingsModel;
  final void Function(bool? value) setRandomizePort;
  final void Function(bool? value) setOpenPort;
  final Function? setEnableDht;
  final Function? setEnablePeerExchange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: Key('Connectivity Expansion Card'),
      elevation: 0,
      expandedColor: ThemeProvider.theme(index).primaryColor,
      baseColor: ThemeProvider.theme(index).primaryColor,
      expandedTextColor: ThemeProvider.theme(index).colorScheme.secondary,
      leading: Icon(FontAwesomeIcons.connectdevelop),
      title: MText(text: 'Connectivity'),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Connectivity option display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(text: 'Incoming Connections', index: index),
            SizedBox(height: 15),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Port Range',
              labelText: 'Port Range',
              isText: false,
              controller: portRangeController,
              index: index,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Randomize Port'),
                    activeColor: ThemeProvider.theme(index).primaryColorDark,
                    tileColor: ThemeProvider.theme(index).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      'Randomize Port',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: randomizePort,
                    onChanged: setRandomizePort,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Open Port'),
                    activeColor: ThemeProvider.theme(index).primaryColorDark,
                    tileColor: ThemeProvider.theme(index).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      'Open Port',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: openPort,
                    onChanged: setOpenPort,
                  ),
                )
              ],
            ),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Maximum HTTP Connections',
              labelText: 'Maximum HTTP Connections',
              isText: false,
              controller: maxHttpConnectionsController,
              index: index,
            ),
            SizedBox(height: 25),
            SText(text: 'Decentralized Peer Discovery', index: index),
            SizedBox(height: 15),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'DHT Port',
              labelText: 'DHT Port',
              controller: dhtPortController,
              isText: false,
              index: index,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Enable DHT'),
                    activeColor: ThemeProvider.theme(index).primaryColorDark,
                    tileColor: ThemeProvider.theme(index).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      'Enable DHT',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: enableDht,
                    onChanged: (value) {
                      // setState(() {
                      //   enableDht = value;
                      // });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CheckboxListTile(
                    key: Key('Checkbox Enable Peer Exchange'),
                    activeColor: ThemeProvider.theme(index).primaryColorDark,
                    tileColor: ThemeProvider.theme(index).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      'Enable Peer Exchange',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: enablePeerExchange,
                    onChanged: (value) {
                      // setState(() {
                      //   enablePeerExchange = value;
                      // });
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            SText(text: 'Peers', index: index),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Minimum Peers',
                labelText: 'Minimum Peers',
                controller: minimumPeerController,
                isText: false,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Maximum Peers',
              labelText: 'Maximum Peers',
              controller: maximumPeerController,
              isText: false,
              index: index,
            ),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Minimum Peers Seeding',
                labelText: 'Minimum Peers Seeding',
                controller: minimumPeerSeedingController,
                isText: false,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Maximum Peers Seeding',
                labelText: 'Maximum Peers Seeding',
                controller: maximumPeerSeedingController,
                isText: false,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Peers Desired',
                labelText: 'Peers Desired',
                controller: peerDesiredController,
                isText: false,
                index: index),
          ],
        )
      ],
    );
  }
}

class BandwidthSection extends StatelessWidget {
  const BandwidthSection({
    Key? key,
    required this.globalDownloadRateController,
    required this.globalUploadRateController,
    required this.uploadSlotPerTorrentController,
    required this.uploadSlotGlobalController,
    required this.downloadSlotPerTorrentController,
    required this.downloadSlotGlobalController,
    required this.index,
  }) : super(key: key);

  final TextEditingController globalDownloadRateController;
  final TextEditingController globalUploadRateController;
  final TextEditingController uploadSlotPerTorrentController;
  final TextEditingController uploadSlotGlobalController;
  final TextEditingController downloadSlotPerTorrentController;
  final TextEditingController downloadSlotGlobalController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: Key('Bandwidth Expansion Card'),
      initiallyExpanded: true,
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme(index).primaryColor,
      baseColor: ThemeProvider.theme(index).primaryColor,
      title: MText(text: 'Bandwidth'),
      leading: Icon(Icons.wifi_rounded),
      contentPadding: EdgeInsets.all(0),
      expandedTextColor: ThemeProvider.theme(index).colorScheme.secondary,
      children: [
        Column(
          key: Key('Bandwidth option display column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SText(text: 'Transfer Rate Throttles', index: index),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Global Download Rate Throttle',
                labelText: 'Global Download Rate Throttle',
                isText: false,
                controller: globalDownloadRateController,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Global Upload Rate Throttle',
                labelText: 'Global Upload Rate Throttle',
                isText: false,
                controller: globalUploadRateController,
                index: index),
            SizedBox(height: 25),
            SText(text: 'Slot Availability', index: index),
            SizedBox(height: 15),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Upload Slots Per Torrent',
                labelText: 'Upload Slots Per Torrent',
                isText: false,
                controller: uploadSlotPerTorrentController,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Upload Slots Global',
                labelText: 'Upload Slots Global',
                controller: uploadSlotGlobalController,
                isText: false,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
                validator: (value) {
                  return null;
                },
                hintText: 'Download Slots Per Torrent',
                labelText: 'Download Slots Per Torrent',
                controller: downloadSlotPerTorrentController,
                isText: false,
                index: index),
            SizedBox(height: 22),
            SettingsTextField(
              validator: (value) {
                return null;
              },
              hintText: 'Download Slots Global',
              labelText: 'Download Slots Global',
              controller: downloadSlotGlobalController,
              isText: false,
              index: index,
            ),
          ],
        )
      ],
    );
  }
}
