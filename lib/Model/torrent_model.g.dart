// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'torrent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TorrentModel _$TorrentModelFromJson(Map<String, dynamic> json) {
  return TorrentModel(
    (json['bytesDone'] as num).toDouble(),
    (json['dateAdded'] as num).toDouble(),
    (json['dateCreated'] as num).toDouble(),
    json['directory'] as String,
    (json['downRate'] as num).toDouble(),
    (json['downTotal'] as num).toDouble(),
    (json['eta'] as num).toDouble(),
    json['hash'] as String,
    json['isInitialSeeding'] as bool,
    json['isPrivate'] as bool,
    json['isSequential'] as bool,
    json['message'] as String,
    json['name'] as String,
    (json['peersConnected'] as num).toDouble(),
    (json['peersTotal'] as num).toDouble(),
    (json['percentComplete'] as num).toDouble(),
    (json['priority'] as num).toDouble(),
    (json['ratio'] as num).toDouble(),
    (json['seedsConnected'] as num).toDouble(),
    (json['seedsTotal'] as num).toDouble(),
    (json['sizeBytes'] as num).toDouble(),
    (json['status'] as List<dynamic>).map((e) => e as String).toList(),
    (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    (json['trackerURIs'] as List<dynamic>).map((e) => e as String).toList(),
    (json['upRate'] as num).toDouble(),
    (json['upTotal'] as num).toDouble(),
  );
}

Map<String, dynamic> _$TorrentModelToJson(TorrentModel instance) =>
    <String, dynamic>{
      'bytesDone': instance.bytesDone,
      'dateAdded': instance.dateAdded,
      'dateCreated': instance.dateCreated,
      'directory': instance.directory,
      'downRate': instance.downRate,
      'downTotal': instance.downTotal,
      'eta': instance.eta,
      'hash': instance.hash,
      'isPrivate': instance.isPrivate,
      'isInitialSeeding': instance.isInitialSeeding,
      'isSequential': instance.isSequential,
      'message': instance.message,
      'name': instance.name,
      'peersConnected': instance.peersConnected,
      'peersTotal': instance.peersTotal,
      'percentComplete': instance.percentComplete,
      'priority': instance.priority,
      'ratio': instance.ratio,
      'seedsConnected': instance.seedsConnected,
      'seedsTotal': instance.seedsTotal,
      'sizeBytes': instance.sizeBytes,
      'status': instance.status,
      'tags': instance.tags,
      'trackerURIs': instance.trackerURIs,
      'upRate': instance.upRate,
      'upTotal': instance.upTotal,
    };
