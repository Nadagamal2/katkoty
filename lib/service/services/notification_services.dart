import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../db/model/notifications_model.dart';

class NotificationService extends GetxService {
  final String url = 'https://katkoty-app.com/admin/api/get_notifications.php';

  Future<List<Notification>> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body) as Map<String, dynamic>;
      final notificationsJson = data['notifications'] as List<dynamic>;
      return notificationsJson
          .map((notificationJson) =>
              Notification.fromJson(notificationJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
