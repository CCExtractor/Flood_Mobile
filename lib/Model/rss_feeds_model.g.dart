// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rss_feeds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RssFeedsModel _$RssFeedsModelFromJson(Map<String, dynamic> json) =>
    RssFeedsModel()
      ..feeds = (json['feeds'] as List<dynamic>)
          .map((e) => FeedsAndRulesModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..rules = (json['rules'] as List<dynamic>)
          .map((e) => RulesModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RssFeedsModelToJson(RssFeedsModel instance) =>
    <String, dynamic>{
      'feeds': instance.feeds,
      'rules': instance.rules,
    };
