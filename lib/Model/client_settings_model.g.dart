// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSettingsModel _$ClientSettingsModelFromJson(Map<String, dynamic> json) {
  return ClientSettingsModel(
    dht: json['dht'] as bool,
    dhtPort: json['dhtPort'] as int,
    directoryDefault: json['directoryDefault'] as String,
    networkHttpMaxOpen: json['networkHttpMaxOpen'] as int,
    networkLocalAddress: (json['networkLocalAddress'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    networkMaxOpenFiles: json['networkMaxOpenFiles'] as int,
    networkPortOpen: json['networkPortOpen'] as bool,
    networkPortRandom: json['networkPortRandom'] as bool,
    networkPortRange: json['networkPortRange'] as String,
    piecesHashOnCompletion: json['piecesHashOnCompletion'] as bool,
    piecesMemoryMax: json['piecesMemoryMax'] as int,
    protocolPex: json['protocolPex'] as bool,
    throttleGlobalDownSpeed: json['throttleGlobalDownSpeed'] as int,
    throttleGlobalUpSpeed: json['throttleGlobalUpSpeed'] as int,
    throttleMaxDownloads: json['throttleMaxDownloads'] as int,
    throttleMaxDownloadsGlobal: json['throttleMaxDownloadsGlobal'] as int,
    throttleMaxPeersNormal: json['throttleMaxPeersNormal'] as int,
    throttleMaxPeersSeed: json['throttleMaxPeersSeed'] as int,
    throttleMaxUploads: json['throttleMaxUploads'] as int,
    throttleMaxUploadsGlobal: json['throttleMaxUploadsGlobal'] as int,
    throttleMinPeersNormal: json['throttleMinPeersNormal'] as int,
    throttleMinPeersSeed: json['throttleMinPeersSeed'] as int,
    trackersNumWant: json['trackersNumWant'] as int,
  );
}

Map<String, dynamic> _$ClientSettingsModelToJson(
        ClientSettingsModel instance) =>
    <String, dynamic>{
      'dht': instance.dht,
      'dhtPort': instance.dhtPort,
      'directoryDefault': instance.directoryDefault,
      'networkHttpMaxOpen': instance.networkHttpMaxOpen,
      'networkLocalAddress': instance.networkLocalAddress,
      'networkMaxOpenFiles': instance.networkMaxOpenFiles,
      'networkPortOpen': instance.networkPortOpen,
      'networkPortRandom': instance.networkPortRandom,
      'networkPortRange': instance.networkPortRange,
      'piecesHashOnCompletion': instance.piecesHashOnCompletion,
      'piecesMemoryMax': instance.piecesMemoryMax,
      'protocolPex': instance.protocolPex,
      'throttleGlobalDownSpeed': instance.throttleGlobalDownSpeed,
      'throttleGlobalUpSpeed': instance.throttleGlobalUpSpeed,
      'throttleMaxPeersNormal': instance.throttleMaxPeersNormal,
      'throttleMaxPeersSeed': instance.throttleMaxPeersSeed,
      'throttleMaxDownloads': instance.throttleMaxDownloads,
      'throttleMaxDownloadsGlobal': instance.throttleMaxDownloadsGlobal,
      'throttleMaxUploads': instance.throttleMaxUploads,
      'throttleMaxUploadsGlobal': instance.throttleMaxUploadsGlobal,
      'throttleMinPeersNormal': instance.throttleMinPeersNormal,
      'throttleMinPeersSeed': instance.throttleMinPeersSeed,
      'trackersNumWant': instance.trackersNumWant,
    };
