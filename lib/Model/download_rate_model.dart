class RateModel {
  String op;
  String path;
  int value;
  RateModel({this.value, this.op, this.path});
  RateModel.fromJson(Map<String, dynamic> json) {
    op = json['op'];
    path = json['path'];
    value = json['value'];
  }
}
