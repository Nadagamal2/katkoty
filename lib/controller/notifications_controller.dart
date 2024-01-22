import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../ads/ad_manager.dart';
import '../db/model/notifications_model.dart';
import '../service/services/notification_services.dart';

class NotificationController extends GetxController {
  final notificationService = NotificationService();
  final RxList<Notification> notifications = <Notification>[].obs;
  final RxList<Notification> favoriteNotifications = <Notification>[].obs;
  late SharedPreferences prefs;
 // final adManager = AdManager();


  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    fetchNotifications();
    loadFavoriteNotifications();
   // adManager.loadInterstitialAd();
  }

  @override
  void onClose() {
    super.onClose();
    saveFavoriteNotifications();
  }

  void addFavoriteNotification(Notification notification) {
    favoriteNotifications.add(notification);
    saveFavoriteNotifications();
  }

  void removeFavoriteNotification(Notification notification) {
    favoriteNotifications.remove(notification);
    saveFavoriteNotifications();
  }

  bool isFavoriteNotification(Notification notification) {
    return favoriteNotifications.contains(notification);
  }

  void fetchNotifications() async {
    try {
      final fetchedNotifications =
          await notificationService.fetchNotifications();
      notifications.assignAll(fetchedNotifications);
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void loadFavoriteNotifications() {
    final favoriteNotificationJsonList =
        prefs.getStringList('favoriteNotifications') ?? [];
    final favoriteNotificationModels = favoriteNotificationJsonList
        .map((json) => Notification.fromJson(jsonDecode(json)))
        .toList();
    favoriteNotifications.assignAll(favoriteNotificationModels);
  }

  void saveFavoriteNotifications() {
    final favoriteNotificationJsonList =
        favoriteNotifications.map((n) => jsonEncode(n.toJson())).toList();
    prefs.setStringList('favoriteNotifications', favoriteNotificationJsonList);
  }
}
