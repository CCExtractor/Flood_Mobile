import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rss_feeds_model.g.dart';

@JsonSerializable()
class RssFeedsModel {
  RssFeedsModel();

  @JsonKey(name: "feeds")
  late List<FeedsAndRulesModel> feeds;

  @JsonKey(name: "rules")
  late List<RulesModel> rules;

  factory RssFeedsModel.fromJson(Map<String, dynamic> json) =>
      _$RssFeedsModelFromJson(json);
  Map<String, dynamic> toJson() => _$RssFeedsModelToJson(this);
}
