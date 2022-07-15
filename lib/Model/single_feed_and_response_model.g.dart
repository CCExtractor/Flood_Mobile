// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_feed_and_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedsAndRulesModel _$FeedsAndRulesModelFromJson(Map<String, dynamic> json) =>
    FeedsAndRulesModel(
      type: json['type'] as String?,
      url: json['url'] as String?,
      label: json['label'] as String?,
      interval: json['interval'] as int?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$FeedsAndRulesModelToJson(FeedsAndRulesModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'label': instance.label,
      'interval': instance.interval,
      '_id': instance.id,
    };
