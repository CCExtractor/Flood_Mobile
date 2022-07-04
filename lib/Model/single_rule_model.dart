import 'package:json_annotation/json_annotation.dart';
part 'single_rule_model.g.dart';

@JsonSerializable()
class RulesModel {
  @JsonKey(name : "type")
  late String type;

  @JsonKey(name : "_id")
  late String id;

  @JsonKey(name : "label")
  late String label;

  @JsonKey(name : "feedIDs")
  late List<String> feedIDs;

  @JsonKey(name : "field")
  late String field;

  @JsonKey(name : "match")
  late String match;

  @JsonKey(name : "exclude")
  late String exclude;

  @JsonKey(name : "destination")
  late String destination;

  @JsonKey(name : "tags")
  late List<String> tags;

  @JsonKey(name : "startOnLoad")
  late bool startOnLoad;

  @JsonKey(name : "isBasePath")
  late bool isBasePath;

  @JsonKey(name : "count")
  late int count;

  RulesModel();

  factory RulesModel.fromJson(Map<String, dynamic> json) => _$RulesModelFromJson(json);
  Map<String, dynamic> toJson() => _$RulesModelToJson(this);
}