import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../controller/notifications_controller.dart';
import '../../../utils/color.dart';
import '../../AskYouerSelf/widget/buttons_dialog.dart';

class FavoritesScreen extends StatelessWidget {
  final NotificationController notificationController = Get.find();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('الإشعارات المفضلة'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Obx(
          () => ListView.separated(
            itemCount: notificationController.favoriteNotifications.length,
            itemBuilder: (context, index) {
              final notification =
                  notificationController.favoriteNotifications[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    //  padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(178, 158, 158, 158),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Row(
                              children: [
                                const Text('رسالة كتكوتي'),
                                const Spacer(),
                                IconButton(
                                  onPressed: () =>
                                      onSharePressed(notification.body),
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.amber,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                    Clipboard.setData(
                                      ClipboardData(text: "${notification.body} \n\n تم النسخ من تطبيق كتكوتي 🐥"),                                    );
                                    Get.snackbar(
                                      'تم النسخ إلي الحافظة',
                                      'تم نسخ نص الإشعار إلى الحافظة',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.doc_on_clipboard_fill,
                                    color: AppbarColor,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(notification.body),
                            actions: const [Center(child: ButtonDialog())],
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //   Text(notification.title),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    DateFormat.yMd()
                                        .format(notification.createdAt),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppbarColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  'assets/images/app_icon.png',
                                  height: 50,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Obx(
                                  () => SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: IconButton(
                                      alignment: Alignment.topLeft,
                                      onPressed: () {
                                        notificationController
                                            .removeFavoriteNotification(
                                                notification);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.heart_fill,
                                        //   Icons.favorite_rounded,
                                        color: notificationController
                                                .isFavoriteNotification(
                                                    notification)
                                            ? Colors.redAccent
                                            : const Color.fromARGB(
                                                255, 217, 215, 215),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(notification.body,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  void onSharePressed(String message) {
    Share.share("$message\n تم النسخ من تطبيق كتكوتي 🐥");
  }
}
