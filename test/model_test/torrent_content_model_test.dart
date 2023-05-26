import 'package:flood_mobile/Model/torrent_content_model.dart';
import 'package:test/test.dart';

void main() {
  group('TorrentContentModel', () {
    test('Test JSON to Model conversion', () {
      final json = {
        'index': 1,
        'path': 'path/to/file.mp4',
        'filename': 'file.mp4',
        'percentComplete': 0.75,
        'priority': 1,
        'sizeBytes': 1024,
      };

      final model = TorrentContentModel.fromJson(json);

      expect(model.index, 1);
      expect(model.path, 'path/to/file.mp4');
      expect(model.filename, 'file.mp4');
      expect(model.percentComplete, 0.75);
      expect(model.priority, 1);
      expect(model.sizeBytes, 1024);
      expect(model.depth, 3);
      expect(model.parentPath, ['path', 'to', 'file.mp4']);
      expect(model.isMediaFile, true);
    });
  });
}
