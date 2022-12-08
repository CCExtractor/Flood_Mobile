import 'package:json_annotation/json_annotation.dart';
part 'single_feed_and_response_model.g.dart';

@JsonSerializable()
class FeedsAndRulesModel {
  @JsonKey(name: "type")
  late String? type;

  @JsonKey(name: "url")
  late String? url;

  @JsonKey(name: "label")
  late String? label;

  @JsonKey(name: "interval")
  late int? interval;

  @JsonKey(name: "_id")
  late String? id;

  @JsonKey(name: "count")
  late int? count;

  FeedsAndRulesModel();

  factory FeedsAndRulesModel.fromJson(Map<String, dynamic> json) =>
      _$FeedsAndRulesModelFromJson(json);
  Map<String, dynamic> toJson() => _$FeedsAndRulesModelToJson(this);
}
