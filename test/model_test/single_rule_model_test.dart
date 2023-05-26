import 'package:flood_mobile/Model/single_rule_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test RulesModel', () {
    late RulesModel model;

    setUp(() {
      model = RulesModel(
        type: 'Type 1',
        label: 'Label 1',
        feedIDs: ['Feed 1', 'Feed 2'],
        field: 'Field 1',
        match: 'Match 1',
        exclude: 'Exclude 1',
        destination: 'Destination 1',
        tags: ['Tag 1', 'Tag 2'],
        startOnLoad: true,
        isBasePath: false,
        id: 'ID 1',
        count: 10,
      );
    });

    test('Test JSON to Model conversion', () {
      final json = {
        "type": "Type 1",
        "label": "Label 1",
        "feedIDs": ["Feed 1", "Feed 2"],
        "field": "Field 1",
        "match": "Match 1",
        "exclude": "Exclude 1",
        "destination": "Destination 1",
        "tags": ["Tag 1", "Tag 2"],
        "startOnLoad": true,
        "isBasePath": false,
        "_id": "ID 1",
        "count": 10,
      };

      model = RulesModel.fromJson(json);

      expect(model.type, "Type 1");
      expect(model.label, "Label 1");
      expect(model.feedIDs.length, 2);
      expect(model.feedIDs[0], "Feed 1");
      expect(model.feedIDs[1], "Feed 2");
      expect(model.field, "Field 1");
      expect(model.match, "Match 1");
      expect(model.exclude, "Exclude 1");
      expect(model.destination, "Destination 1");
      expect(model.tags.length, 2);
      expect(model.tags[0], "Tag 1");
      expect(model.tags[1], "Tag 2");
      expect(model.startOnLoad, true);
      expect(model.isBasePath, false);
      expect(model.id, "ID 1");
      expect(model.count, 10);
    });

    test('Test Model to JSON conversion', () {
      final json = model.toJson();

      expect(json["type"], "Type 1");
      expect(json["label"], "Label 1");
      expect(json["feedIDs"].length, 2);
      expect(json["feedIDs"][0], "Feed 1");
      expect(json["feedIDs"][1], "Feed 2");
      expect(json["field"], "Field 1");
      expect(json["match"], "Match 1");
      expect(json["exclude"], "Exclude 1");
      expect(json["destination"], "Destination 1");
      expect(json["tags"].length, 2);
      expect(json["tags"][0], "Tag 1");
      expect(json["tags"][1], "Tag 2");
      expect(json["startOnLoad"], true);
      expect(json["isBasePath"], false);
      expect(json["_id"], "ID 1");
      expect(json["count"], 10);
    });
  });
}
