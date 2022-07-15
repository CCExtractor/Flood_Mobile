// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RulesModel _$RulesModelFromJson(Map<String, dynamic> json) => RulesModel(
      type: json['type'] as String?,
      label: json['label'] as String?,
      feedIDs:
          (json['feedIDs'] as List<dynamic>).map((e) => e as String?).toList(),
      field: json['field'] as String?,
      match: json['match'] as String?,
      exclude: json['exclude'] as String?,
      destination: json['destination'] as String?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String?).toList(),
      startOnLoad: json['startOnLoad'] as bool,
      isBasePath: json['isBasePath'] as bool,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$RulesModelToJson(RulesModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'feedIDs': instance.feedIDs,
      'field': instance.field,
      'match': instance.match,
      'exclude': instance.exclude,
      'destination': instance.destination,
      'tags': instance.tags,
      'startOnLoad': instance.startOnLoad,
      'isBasePath': instance.isBasePath,
      '_id': instance.id,
    };
