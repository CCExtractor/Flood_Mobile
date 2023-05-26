import 'package:flood_mobile/Model/download_rate_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test RateModel', () {
    final rate = RateModel(
      downRate: 100,
      downTotal: 200,
      upRate: 50,
      upTotal: 150,
    );

    final rateJson = {
      'downRate': 100,
      'downTotal': 200,
      'upRate': 50,
      'upTotal': 150,
    };

    test('Test JSON to Model', () {
      final rateFromJson = RateModel.fromJson(rateJson);
      expect(rateFromJson.downRate, rate.downRate);
      expect(rateFromJson.downTotal, rate.downTotal);
      expect(rateFromJson.upRate, rate.upRate);
      expect(rateFromJson.upTotal, rate.upTotal);
    });
  });
}
