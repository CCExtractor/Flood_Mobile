class RateModel {
  int downRate;
  int downTotal;
  int upRate;
  int upTotal;

  RateModel({
    required this.downRate,
    required this.downTotal,
    required this.upRate,
    required this.upTotal,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      downTotal: json['downTotal'],
      downRate: json['downRate'],
      upTotal: json['upTotal'],
      upRate: json['upRate'],
    );
  }
}
