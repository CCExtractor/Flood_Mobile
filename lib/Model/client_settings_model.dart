import 'package:json_annotation/json_annotation.dart';
part 'client_settings_model.g.dart';

@JsonSerializable()
class ClientSettingsModel {
  bool dht;
  int dhtPort;
  String directoryDefault;
  int networkHttpMaxOpen;
  List<String> networkLocalAddress;
  int networkMaxOpenFiles;
  bool networkPortOpen;
  bool networkPortRandom;
  String networkPortRange;
  bool piecesHashOnCompletion;
  int piecesMemoryMax;
  bool protocolPex;
  int throttleGlobalDownSpeed;
  int throttleGlobalUpSpeed;
  int throttleMaxPeersNormal;
  int throttleMaxPeersSeed;
  int throttleMaxDownloads;
  int throttleMaxDownloadsGlobal;
  int throttleMaxUploads;
  int throttleMaxUploadsGlobal;
  int throttleMinPeersNormal;
  int throttleMinPeersSeed;
  int trackersNumWant;

  ClientSettingsModel({
    required this.dht,
    required this.dhtPort,
    required this.directoryDefault,
    required this.networkHttpMaxOpen,
    required this.networkLocalAddress,
    required this.networkMaxOpenFiles,
    required this.networkPortOpen,
    required this.networkPortRandom,
    required this.networkPortRange,
    required this.piecesHashOnCompletion,
    required this.piecesMemoryMax,
    required this.protocolPex,
    required this.throttleGlobalDownSpeed,
    required this.throttleGlobalUpSpeed,
    required this.throttleMaxDownloads,
    required this.throttleMaxDownloadsGlobal,
    required this.throttleMaxPeersNormal,
    required this.throttleMaxPeersSeed,
    required this.throttleMaxUploads,
    required this.throttleMaxUploadsGlobal,
    required this.throttleMinPeersNormal,
    required this.throttleMinPeersSeed,
    required this.trackersNumWant,
  });

  factory ClientSettingsModel.fromJson(Map<String, dynamic> data) =>
      _$ClientSettingsModelFromJson(data);

  Map<String, dynamic> toJson() => _$ClientSettingsModelToJson(this);
}
