// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientSettingsModel _$ClientSettingsModelFromJson(Map<String, dynamic> json) {
  return ClientSettingsModel(
    json['dht'] as bool,
    json['dhtPort'] as int,
    json['directoryDefault'] as String,
    json['networkHttpMaxOpen'] as int,
    (json['networkLocalAddress'] as List)?.map((e) => e as String)?.toList(),
    json['networkMaxOpenFiles'] as int,
    json['networkPortOpen'] as bool,
    json['networkPortRandom'] as bool,
    json['networkPortRange'] as String,
    json['piecesHashOnCompletion'] as bool,
    json['piecesMemoryMax'] as int,
    json['protocolPex'] as bool,
    json['throttleGlobalDownSpeed'] as int,
    json['throttleGlobalUpSpeed'] as int,
    json['throttleMaxDownloads'] as int,
    json['throttleMaxDownloadsGlobal'] as int,
    json['throttleMaxPeersNormal'] as int,
    json['throttleMaxPeersSeed'] as int,
    json['throttleMaxUploads'] as int,
    json['throttleMaxUploadsGlobal'] as int,
    json['throttleMinPeersNormal'] as int,
    json['throttleMinPeersSeed'] as int,
    json['trackersNumWant'] as int,
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
