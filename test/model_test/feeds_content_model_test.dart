import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/feeds_content_model.dart';

void main() {
  group('Test FeedsContentsModel', () {
    final feedsContents = FeedsContentsModel(
      title: 'Sample Title',
      urls: ['http://example.com/image1.jpg', 'http://example.com/image2.jpg'],
    );

    final feedsContentsJson = {
      'title': 'Sample Title',
      'urls': [
        'http://example.com/image1.jpg',
        'http://example.com/image2.jpg'
      ],
    };

    test('Test JSON to Model', () {
      final feedsContentsFromJson =
          FeedsContentsModel.fromJson(feedsContentsJson);
      expect(feedsContentsFromJson.title, feedsContents.title);
      expect(feedsContentsFromJson.urls, feedsContents.urls);
    });
  });
}
