class NotificationModel {
  List<NotificationContentModel> notifications = [];
  int read;
  int total;
  int unread;

  NotificationModel({
    required this.read,
    required this.notifications,
    required this.total,
    required this.unread,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    dynamic notificationsList = json['notifications'].toList();
    List<NotificationContentModel> list = [];
    for (var data in notificationsList) {
      list.add(NotificationContentModel.fromJson(data));
    }

    return NotificationModel(
      read: json['count']['read'],
      notifications: list,
      total: json['count']['total'],
      unread: json['count']['unread'],
    );
  }
}

class NotificationContentModel {
  int ts;
  String name;
  String id;
  bool read;
  String identification;
  String status;

  NotificationContentModel({
    required this.identification,
    required this.id,
    required this.name,
    required this.read,
    required this.ts,
    required this.status,
  });

  factory NotificationContentModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String status;
    if (id == 'notification.torrent.finished') {
      status = 'Finished Download';
    } else {
      status = 'Notification';
    }
    return NotificationContentModel(
      identification: json['_id'],
      id: json['id'],
      name: json['data']['name'],
      read: json['read'],
      ts: json['ts'],
      status: status,
    );
  }
}
