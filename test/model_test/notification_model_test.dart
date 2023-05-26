import 'package:flood_mobile/Model/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test NotificationModel', () {
    final notification1 = NotificationContentModel(
      identification: 'id1',
      id: 'notification.torrent.finished',
      name: 'Notification 1',
      read: true,
      ts: 1621836000,
      status: 'Finished Download',
    );

    final notification2 = NotificationContentModel(
      identification: 'id2',
      id: 'notification.torrent.started',
      name: 'Notification 2',
      read: false,
      ts: 1621837000,
      status: 'Notification',
    );

    final notificationJson = {
      'count': {
        'read': 2,
        'total': 2,
        'unread': 0,
      },
      'notifications': [
        {
          '_id': 'id1',
          'id': 'notification.torrent.finished',
          'data': {'name': 'Notification 1'},
          'read': true,
          'ts': 1621836000,
        },
        {
          '_id': 'id2',
          'id': 'notification.torrent.started',
          'data': {'name': 'Notification 2'},
          'read': false,
          'ts': 1621837000,
        },
      ],
    };

    test('Test JSON to Model', () {
      final notificationModel = NotificationModel.fromJson(notificationJson);

      expect(notificationModel.read, 2);
      expect(notificationModel.total, 2);
      expect(notificationModel.unread, 0);

      expect(notificationModel.notifications.length, 2);

      expect(notificationModel.notifications[0].identification,
          notification1.identification);
      expect(notificationModel.notifications[0].id, notification1.id);
      expect(notificationModel.notifications[0].name, notification1.name);
      expect(notificationModel.notifications[0].read, notification1.read);
      expect(notificationModel.notifications[0].ts, notification1.ts);
      expect(notificationModel.notifications[0].status, notification1.status);

      expect(notificationModel.notifications[1].identification,
          notification2.identification);
      expect(notificationModel.notifications[1].id, notification2.id);
      expect(notificationModel.notifications[1].name, notification2.name);
      expect(notificationModel.notifications[1].read, notification2.read);
      expect(notificationModel.notifications[1].ts, notification2.ts);
      expect(notificationModel.notifications[1].status, notification2.status);
    });
  });
}
