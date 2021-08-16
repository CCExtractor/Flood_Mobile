class RateModel {
  String op;
  String path;
  int value;
  RateModel({
    required this.value,
    required this.op,
    required this.path,
  });
  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      op: json['op'],
      path: json['path'],
      value: json['value'],
    );
  }
}
