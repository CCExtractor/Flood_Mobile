// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'torrent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TorrentModel _$TorrentModelFromJson(Map<String, dynamic> json) => TorrentModel(
      bytesDone: (json['bytesDone'] as num).toDouble(),
      dateAdded: (json['dateAdded'] as num).toDouble(),
      dateCreated: (json['dateCreated'] as num).toDouble(),
      directory: json['directory'] as String,
      downRate: (json['downRate'] as num).toDouble(),
      downTotal: (json['downTotal'] as num).toDouble(),
      eta: (json['eta'] as num).toDouble(),
      hash: json['hash'] as String,
      isInitialSeeding: json['isInitialSeeding'] as bool,
      isPrivate: json['isPrivate'] as bool,
      isSequential: json['isSequential'] as bool,
      message: json['message'] as String,
      name: json['name'] as String,
      peersConnected: (json['peersConnected'] as num).toDouble(),
      peersTotal: (json['peersTotal'] as num).toDouble(),
      percentComplete: (json['percentComplete'] as num).toDouble(),
      priority: (json['priority'] as num).toDouble(),
      ratio: (json['ratio'] as num).toDouble(),
      seedsConnected: (json['seedsConnected'] as num).toDouble(),
      seedsTotal: (json['seedsTotal'] as num).toDouble(),
      sizeBytes: (json['sizeBytes'] as num).toDouble(),
      status:
          (json['status'] as List<dynamic>).map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      trackerURIs: (json['trackerURIs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      upRate: (json['upRate'] as num).toDouble(),
      upTotal: (json['upTotal'] as num).toDouble(),
    );

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
