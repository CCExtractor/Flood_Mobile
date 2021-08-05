class NotificationModel {
  List<NotificationContentModel> notifications = [];
  int read;
  int total;
  int unread;

  NotificationModel({this.read, this.notifications, this.total, this.unread});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    read = json['count']['read'];
    total = json['count']['total'];
    unread = json['count']['unread'];
    dynamic notificationsList = json['notifications'].toList();
    for (var data in notificationsList) {
      notifications.add(NotificationContentModel.fromJson(data));
    }
  }
}

class NotificationContentModel {
  int ts;
  String name;
  String id;
  bool read;
  String identification;
  String status;

  NotificationContentModel(
      {this.identification,
      this.id,
      this.name,
      this.read,
      this.ts,
      this.status});

  NotificationContentModel.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    name = json['data']['name'];
    id = json['id'];
    read = json['read'];
    identification = json['_id'];
    if (id == 'notification.torrent.finished') {
      status = 'Finished Download';
    } else {
      status = 'Notification';
    }
  }
}
