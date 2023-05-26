import 'package:flood_mobile/Model/rss_feeds_model.dart';
import 'package:test/test.dart';

void main() {
  group('RssFeedsModel', () {
    test('Test JSON to Model conversion', () {
      final json = {
        "feeds": [
          {
            "type": "Type 1",
            "url": "https://example.com/feed1",
            "label": "Label 1",
            "interval": 60,
            "_id": "ID 1",
            "count": 10
          },
          {
            "type": "Type 2",
            "url": "https://example.com/feed2",
            "label": "Label 2",
            "interval": 120,
            "_id": "ID 2",
            "count": 20
          }
        ],
        "rules": [
          {
            "type": "Type A",
            "label": "Label A",
            "feedIDs": ["ID 1"],
            "field": "Field 1",
            "match": "Match 1",
            "exclude": "Exclude 1",
            "destination": "Destination 1",
            "tags": ["Tag 1", "Tag 2"],
            "startOnLoad": true,
            "isBasePath": false,
            "_id": "Rule ID 1",
            "count": 5
          },
          {
            "type": "Type B",
            "label": "Label B",
            "feedIDs": ["ID 2"],
            "field": "Field 2",
            "match": "Match 2",
            "exclude": "Exclude 2",
            "destination": "Destination 2",
            "tags": ["Tag 3", "Tag 4"],
            "startOnLoad": false,
            "isBasePath": true,
            "_id": "Rule ID 2",
            "count": 10
          }
        ]
      };

      final model = RssFeedsModel.fromJson(json);

      expect(model.feeds.length, 2);
      expect(model.feeds[0].type, "Type 1");
      expect(model.feeds[0].url, "https://example.com/feed1");
      expect(model.feeds[0].label, "Label 1");
      expect(model.feeds[0].interval, 60);
      expect(model.feeds[0].id, "ID 1");
      expect(model.feeds[0].count, 10);

      expect(model.feeds[1].type, "Type 2");
      expect(model.feeds[1].url, "https://example.com/feed2");
      expect(model.feeds[1].label, "Label 2");
      expect(model.feeds[1].interval, 120);
      expect(model.feeds[1].id, "ID 2");
      expect(model.feeds[1].count, 20);

      expect(model.rules.length, 2);
      expect(model.rules[0].type, "Type A");
      expect(model.rules[0].label, "Label A");
      expect(model.rules[0].feedIDs, ["ID 1"]);
      expect(model.rules[0].field, "Field 1");
      expect(model.rules[0].match, "Match 1");
      expect(model.rules[0].exclude, "Exclude 1");
      expect(model.rules[0].destination, "Destination 1");
      expect(model.rules[0].tags, ["Tag 1", "Tag 2"]);
      expect(model.rules[0].startOnLoad, true);
      expect(model.rules[0].isBasePath, false);
      expect(model.rules[0].id, "Rule ID 1");
      expect(model.rules[0].count, 5);

      expect(model.rules[1].type, "Type B");
      expect(model.rules[1].label, "Label B");
      expect(model.rules[1].feedIDs, ["ID 2"]);
      expect(model.rules[1].field, "Field 2");
      expect(model.rules[1].match, "Match 2");
      expect(model.rules[1].exclude, "Exclude 2");
      expect(model.rules[1].destination, "Destination 2");
      expect(model.rules[1].tags, ["Tag 3", "Tag 4"]);
      expect(model.rules[1].startOnLoad, false);
      expect(model.rules[1].isBasePath, true);
      expect(model.rules[1].id, "Rule ID 2");
      expect(model.rules[1].count, 10);
    });
  });
}
