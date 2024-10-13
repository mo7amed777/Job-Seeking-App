class NotificationModel {
  bool? success;
  String? message;
  NotificationList? notificationList;

  NotificationModel({this.success, this.message, this.notificationList});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    notificationList =
        json['data'] != null ? NotificationList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (notificationList != null) {
      data['data'] = notificationList!.toJson();
    }
    return data;
  }
}

class NotificationList {
  List<Notification>? notifications;

  NotificationList({this.notifications});

  NotificationList.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notification>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  int? id;
  String? title;
  String? description;
  String? date;

  Notification({this.id, this.title, this.description, this.date});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}
