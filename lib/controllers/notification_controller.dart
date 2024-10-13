import 'package:get/get.dart';
import 'package:eservices/models/notification_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class NotificationController extends GetxController {
  bool loading = false;
  NotificationModel notificationModel = NotificationModel();
  List<Notification>? get notifications =>
      notificationModel.notificationList?.notifications;

  Future<void> getNotification() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.notifications);
    // Log the response status and data

    if (response.isSuccess) {
      notificationModel = NotificationModel.fromJson(response.responseData);
    } else {}

    loading = false;
    update();
  }
}
