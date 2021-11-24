import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Components/settings_text_field.dart';
import 'package:flood_mobile/Components/text_size.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
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
            backgroundColor: ThemeProvider.theme.primaryColorDark,
            onPressed: () {
              ClientSettingsModel newClientSettingsModel = new ClientSettingsModel(
                  dht: clientSettingsModel.clientSettings.dht,
                  dhtPort: clientSettingsModel.clientSettings.dhtPort,
                  directoryDefault:
                      clientSettingsModel.clientSettings.directoryDefault,
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
            },
            icon: Icon(
              Icons.save,
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
            ),
            label: Text(
              "Save",
              style: TextStyle(
                  color: ThemeProvider.theme.textTheme.bodyText1?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: ThemeProvider.theme.primaryColor,
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
                      globalDownloadRateController:
                          globalDownloadRateController,
                      globalUploadRateController: globalUploadRateController,
                      uploadSlotPerTorrentController:
                          uploadSlotPerTorrentController,
                      uploadSlotGlobalController: uploadSlotGlobalController,
                      downloadSlotPerTorrentController:
                          downloadSlotPerTorrentController,
                      downloadSlotGlobalController:
                          downloadSlotGlobalController),
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
                      maxMemoryUsageController: maxMemoryUsageController),
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
                      hp: hp),
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
      required this.model})
      : super(key: key);

  final double hp;
  final String upSpeed;
  final String downSpeed;
  final void Function(String? value) setUpSpeed;
  final void Function(String? value) setDownSpeed;
  final ClientSettingsProvider model;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme.primaryColor,
      baseColor: ThemeProvider.theme.primaryColor,
      title: MText(text: 'Speed Limit'),
      leading: Icon(Icons.speed_rounded),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
            ),
            SText(text: 'Download'),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ThemeProvider.theme.backgroundColor,
                      border: null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ThemeProvider.theme.backgroundColor,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
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
            SText(text: 'Upload'),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: ThemeProvider.theme.backgroundColor,
                      border: null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ThemeProvider.theme.backgroundColor,
                        isExpanded: true,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: ThemeProvider.theme.textTheme.bodyText1?.color,
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
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: ThemeProvider.theme.accentColor,
                      ),
                      child: Center(
                        child: Text(
                          "Set",
                          style: TextStyle(
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1?.color,
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
  const AuthenticationSection({
    Key? key,
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
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme.primaryColor,
      baseColor: ThemeProvider.theme.primaryColor,
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
                    activeColor: ThemeProvider.theme.primaryColorDark,
                    tileColor: ThemeProvider.theme.backgroundColor,
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
                      color: ThemeProvider.theme.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: client,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: ThemeProvider.theme.backgroundColor,
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
                                tileColor: ThemeProvider.theme.backgroundColor,
                                activeColor:
                                    ThemeProvider.theme.primaryColorDark,
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
                              activeColor: ThemeProvider.theme.primaryColorDark,
                              tileColor: ThemeProvider.theme.backgroundColor,
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
                              validator: (value) {},
                              hintText: 'eg. ~/.local/share/rtorrent',
                              labelText: 'Path',
                              controller: pathController,
                            )
                          : Column(
                              children: [
                                SettingsTextField(
                                  validator: (value) {},
                                  hintText: 'Host or IP',
                                  labelText: 'Host',
                                  controller: hostController,
                                ),
                                SizedBox(height: 20),
                                SettingsTextField(
                                  validator: (value) {},
                                  hintText: 'Port',
                                  labelText: 'Port',
                                  controller: portController,
                                )
                              ],
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: ElevatedButton(
                      onPressed: () {
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
                              port: int.parse(portController.text)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: ThemeProvider.theme.accentColor,
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1?.color,
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
  }) : super(key: key);

  final TextEditingController defaultDownloadDirectoryController;
  final TextEditingController maximumOpenFilesController;
  final bool verifyHash;
  final TextEditingController maxMemoryUsageController;
  final void Function(bool? value) setVerifyHash;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme.primaryColor,
      baseColor: ThemeProvider.theme.primaryColor,
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
                        activeColor: ThemeProvider.theme.primaryColorDark,
                        tileColor: ThemeProvider.theme.backgroundColor,
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
      required this.randomizePort})
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

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      elevation: 0,
      expandedColor: ThemeProvider.theme.primaryColor,
      baseColor: ThemeProvider.theme.primaryColor,
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
                    activeColor: ThemeProvider.theme.primaryColorDark,
                    tileColor: ThemeProvider.theme.backgroundColor,
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
                    activeColor: ThemeProvider.theme.primaryColorDark,
                    tileColor: ThemeProvider.theme.backgroundColor,
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
                    activeColor: ThemeProvider.theme.primaryColorDark,
                    tileColor: ThemeProvider.theme.backgroundColor,
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
                    activeColor: ThemeProvider.theme.primaryColorDark,
                    tileColor: ThemeProvider.theme.backgroundColor,
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
  }) : super(key: key);

  final TextEditingController globalDownloadRateController;
  final TextEditingController globalUploadRateController;
  final TextEditingController uploadSlotPerTorrentController;
  final TextEditingController uploadSlotGlobalController;
  final TextEditingController downloadSlotPerTorrentController;
  final TextEditingController downloadSlotGlobalController;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      initiallyExpanded: true,
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeProvider.theme.primaryColor,
      baseColor: ThemeProvider.theme.primaryColor,
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
    );
  }
}
