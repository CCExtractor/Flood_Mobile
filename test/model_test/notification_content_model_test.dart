import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test NotificationContentModel', () {
    final notification = NotificationContentModel(
      identification: 'sample_id',
      id: 'notification.torrent.finished',
      name: 'Sample Name',
      read: true,
      ts: 1621836000,
      status: 'Finished Download',
    );

    final notificationJson = {
      '_id': 'sample_id',
      'id': 'notification.torrent.finished',
      'data': {'name': 'Sample Name'},
      'read': true,
      'ts': 1621836000,
      'status': 'Finished Download',
    };

    test('Test JSON to Model', () {
      final notificationFromJson =
          NotificationContentModel.fromJson(notificationJson);
      expect(notificationFromJson.identification, notification.identification);
      expect(notificationFromJson.id, notification.id);
      expect(notificationFromJson.name, notification.name);
      expect(notificationFromJson.read, notification.read);
      expect(notificationFromJson.ts, notification.ts);
      expect(notificationFromJson.status, notification.status);
    });
  });
}
