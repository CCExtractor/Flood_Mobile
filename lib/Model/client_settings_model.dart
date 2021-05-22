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

  ClientSettingsModel(
      this.dht,
      this.dhtPort,
      this.directoryDefault,
      this.networkHttpMaxOpen,
      this.networkLocalAddress,
      this.networkMaxOpenFiles,
      this.networkPortOpen,
      this.networkPortRandom,
      this.networkPortRange,
      this.piecesHashOnCompletion,
      this.piecesMemoryMax,
      this.protocolPex,
      this.throttleGlobalDownSpeed,
      this.throttleGlobalUpSpeed,
      this.throttleMaxDownloads,
      this.throttleMaxDownloadsGlobal,
      this.throttleMaxPeersNormal,
      this.throttleMaxPeersSeed,
      this.throttleMaxUploads,
      this.throttleMaxUploadsGlobal,
      this.throttleMinPeersNormal,
      this.throttleMinPeersSeed,
      this.trackersNumWant);
  factory ClientSettingsModel.fromJson(Map<String, dynamic> data) =>
      _$ClientSettingsModelFromJson(data);
  Map<String, dynamic> toJson() => _$ClientSettingsModelToJson(this);
}
