import 'package:flood_mobile/Model/single_feed_and_response_model.dart';
import 'package:test/test.dart';

void main() {
  group('FeedsAndRulesModel', () {
    late FeedsAndRulesModel model;

    setUp(() {
      final json = {
        "type": "Type 1",
        "url": "https://example.com/feed1",
        "label": "Label 1",
        "interval": 60,
        "_id": "ID 1",
        "count": 10
      };
      model = FeedsAndRulesModel.fromJson(json);
    });

    test('Test JSON to Model conversion', () {
      expect(model.type, "Type 1");
      expect(model.url, "https://example.com/feed1");
      expect(model.label, "Label 1");
      expect(model.interval, 60);
      expect(model.id, "ID 1");
      expect(model.count, 10);
    });

    test('Test Model to JSON conversion', () {
      final json = model.toJson();

      expect(json["type"], "Type 1");
      expect(json["url"], "https://example.com/feed1");
      expect(json["label"], "Label 1");
      expect(json["interval"], 60);
      expect(json["_id"], "ID 1");
      expect(json["count"], 10);
    });
  });
}
