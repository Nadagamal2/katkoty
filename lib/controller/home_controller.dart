import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:katkoty/ads/ad_manager.dart';
import 'package:katkoty/controller/auth_controller.dart';
import 'package:katkoty/controller/get_fadfda_controller.dart';
import 'package:katkoty/models/GiftImageModel.dart';
import 'package:katkoty/models/QoutesModelresponse.dart';
import 'package:katkoty/models/ShokModelresponse.dart';
import 'package:katkoty/models/WansModelresponse.dart';
import 'package:katkoty/models/resources.dart';
import 'package:katkoty/models/status.dart';
import 'package:katkoty/packages/alarm/utils/alarms_manager.dart';
import 'package:katkoty/packages/alarm/utils/notification_manager.dart';
import 'package:katkoty/service/api_service.dart';
import 'package:katkoty/utils/notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../service/data_service.dart';
import '../service/shared_preference/user_preference.dart';
import '../utils/color.dart';
import '../utils/list.dart';
import '../view/El_Azqar/widget/custom_dialog.dart';
import '../view/screens/notifications/notification_screen.dart';
import '../view/widgets/custom_text_form_field.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  static ApiService apiService = Get.find();
  static MyDialogController myDialogController = Get.find();
  //final adManager = AdManager();

  RxString adminUid = ''.obs;
  RxString userBirthDate = ''.obs;
  RxString userName = ''.obs;
  RxString facebookPage = ''.obs;
  RxString telegramPage = ''.obs;
  RxInt selectedColorIndex = RxInt(0);
  RxBool showWheel = true.obs;
  RxBool lang = false.obs;
  Rx<Locale> language = const Locale('ar', 'EG').obs;
  RxBool giftOpen = true.obs;
  RxList giftImages = [].obs;
  RxBool userLoggedIn = false.obs;
  ConfettiController showController = ConfettiController();
  final RxBool isLoggedIn = false.obs;
  var hasShownGreeting = false.obs;

  TextEditingController changeNameController = TextEditingController();
  TextEditingController changeBirthDateController = TextEditingController();

  show() {
    showController.play();
  }

  stop() {
    showController.stop();
  }

  String welTitle() {
    var hour = DateFormat('HH').format(DateTime.now());
    if (int.parse(hour) < 12) {
      return 'صباح الخير \n والمقصود بالخير وجودك'.tr;
    } else {
      return 'مساء الخير \n والمقصود بالخير وجودك'.tr;
    }
  }

  req() async {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          return Get.defaultDialog(
              title: 'الاشعارات'.tr,
              textConfirm: 'تمكين'.tr,
              textCancel: 'إلغاء'.tr,
              confirmTextColor: Colors.black,
              cancelTextColor: Colors.black,
              radius: 20,
              onConfirm: () {
                AwesomeNotifications().requestPermissionToSendNotifications(
                  permissions: [
                    NotificationPermission.Alert,
                    NotificationPermission.Sound,
                    NotificationPermission.Badge,
                    NotificationPermission.Vibration,
                    NotificationPermission.Light,
                    NotificationPermission.FullScreenIntent,
                  ],
                );
                welcomeDialog();
              },
              content: Column(
                children: [
                  Text(
                    '${'مرحبا'.tr} ${AuthController.userName} ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('يريد التطبيق الوصول للاشعارات للتنبيهات'.tr),
                ],
              ));
        } else {
          welcomeDialog();
        }
      },
    );
  }

  RxInt tabIndex = 0.obs;
  RxList links = [].obs;
  RxList quotes = [].obs;
  RxList shok = [].obs;
  RxList wans = [].obs;

  spinningWheel() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
              height: 250,
              width: 250,
              child: Visibility(
                  visible: showWheel.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 15, color: const Color(0xffDEEDF8)),
                          shape: BoxShape.circle,
                        ),
                        height: 200,
                        width: 200,
                        child: FortuneWheel(
                          physics: CircularPanPhysics(
                            duration: const Duration(seconds: 1),
                            curve: Curves.decelerate,
                          ),
                          onAnimationStart: () {
                            addGiftsImages();
                            tabIndex.value = Random().nextInt(6);
                          },
                          onAnimationEnd: () {
                            Navigator.of(Get.overlayContext!,
                                    rootNavigator: true)
                                .pop();
                            selectGiftImage();
                            int selectedIndex = selectedColorIndex.value;
                            selectedColorIndex.value = selectedIndex;
                          },
                          selected: tabIndex.stream,
                          items: [
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xff7CA1BC),
                                borderColor:
                                    0 == 0 ? itemColors[0] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xffB3E59F),
                                borderColor:
                                    1 == 0 ? itemColors[1] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xffBEDDF3),
                                borderColor:
                                    2 == 0 ? itemColors[1] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xffFFE07D),
                                borderColor:
                                    3 == 0 ? itemColors[1] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xffE28086),
                                borderColor:
                                    4 == 0 ? itemColors[1] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: const Color(0xffFFC250),
                                borderColor:
                                    5 == 0 ? itemColors[1] : Colors.transparent,
                              ),
                              child: const RotationTransition(
                                turns: AlwaysStoppedAnimation(90 / 360),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Inner circular widget
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

  void downloadImage() async {
    try {
      print(giftImages.first);
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(giftImages.first);
      if (imageId == null) {
        return;
      } else {
        Fluttertoast.showToast(msg: "تم حفظ الصورة بنجاح");
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  selectGiftImage() {
    return Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 30, bottom: 10),
        title: 'رسالتك'.tr,
        radius: 20,
        actions: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                downloadImage();
              },
              child: Text('حفظ الصورة'.tr)),
          ElevatedButton(
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  backgroundColor: AppbarColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  'حسناً'.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
        ],
        content: Column(
          children: [
            Visibility(
              visible: giftOpen.value,
              child: SizedBox(
                height: 350,
                width: 350,
                child: CachedNetworkImage(
                  imageUrl: giftImages.first,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    margin: const EdgeInsets.all(100),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ));
  }

  birthDayDialog() {
    return Get.defaultDialog(
        title: 'birth_date_msg'.tr,
        textConfirm: 'شكرا'.tr,
        confirmTextColor: Colors.black,
        radius: 20,
        onConfirm: () {
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
          stop();
        },
        content: Column(
          children: [
            Lottie.asset('assets/lottie/birthday.json'),
          ],
        ));
  }

  getQuotes() async {
    quotes.clear();
    Resource<QoutesModelresponse> response = await apiService.getTodayQuotes();
    if (response.status == Status.SUCCESS) {
      quotes.clear();
      quotes.addAll(response.data!.quotes!.map((e) => e.text).toList());
      quotes.add(UserPreferences.sharedPreferences.setString("getQuotes",
          response.data!.quotes!.map((e) => e.text).toList().first.toString()));
    } else {
      quotes.add(UserPreferences.sharedPreferences.getString("getQuotes"));
    }
  }

  getShok() async {
    shok.clear();
    Resource<ShokModelresponse> response = await apiService.getShokApi();
    if (response.status == Status.SUCCESS) {
      shok.clear();
      shok.addAll(response.data!.shok!.map((e) => e.text).toList());
      shok.add(UserPreferences.sharedPreferences.setString("getShok",
          response.data!.shok!.map((e) => e.text).toList().first.toString()));
    } else {
      shok.add(UserPreferences.sharedPreferences.getString("getShok"));
    }
  }

  getWans() async {
    wans.clear();
    Resource<WansModelresponse> response = await apiService.getWansApi();
    if (response.status == Status.SUCCESS) {
      wans.clear();
      wans.addAll(response.data!.wans!.map((e) => e.text).toList());
      wans.add(UserPreferences.sharedPreferences.setString("getWans",
          response.data!.wans!.map((e) => e.text).toList().first.toString()));
    } else {
      wans.add(UserPreferences.sharedPreferences.getString("getWans"));
    }
  }

  void quotesDialog() {
    Get.defaultDialog(
      title: 'رسالتك اليوم'.tr,
      titlePadding: const EdgeInsets.all(15),
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      confirmTextColor: Colors.white,
      radius: 20,
      content: Center(
        child: Column(
          children: [
            Text(
              quotes.first,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () => onSharePressed(quotes.first),
                  icon: const Icon(
                    Icons.share,
                    color: Colors.amber,
                  ),
                ),
                const Text(
                  "مشاركة",
                  style: TextStyle(
                    color: AppbarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: SizedBox(
            width: 119,
            height: 43,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                getQuotes();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppbarColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: Text(
                'حسناً'.tr,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    ).then((value) => getQuotes());
  }

  void shokDialog() {
    //  adManager.loadInterstitialAd();
    Get.defaultDialog(
        title: 'shok'.tr,
        confirmTextColor: Colors.white,
        radius: 20,
        titlePadding: const EdgeInsets.all(15),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: SizedBox(
              width: 119,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                  getShok();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppbarColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  'حسناً'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        content: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    shok.first,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () => onSharePressed(shok.first),
                      icon: const Icon(
                        Icons.share,
                        color: Colors.amber,
                      )),
                  const Text("مشاركة",
                      style: TextStyle(
                        color: AppbarColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                  const Spacer(),
                ],
              )
            ],
          ),
        )).then((value) => getShok());
  }

  void wansDialog() {
    Get.defaultDialog(
        title: 'wans'.tr,
        titlePadding: const EdgeInsets.all(15),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        confirmTextColor: Colors.white,
        radius: 20,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: SizedBox(
              width: 119,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                  getWans();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppbarColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  'حسناً'.tr,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
        content: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    wans.first,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () => onSharePressed(wans.first),
                      icon: const Icon(
                        Icons.share,
                        color: Colors.amber,
                      )),
                  const Text("مشاركة",
                      style: TextStyle(
                        color: AppbarColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                  const Spacer(),
                ],
              )
            ],
          ),
        )).then((value) => getWans());
  }

  void welcomeDialog() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.all(30),
        title: welTitle(),
        radius: 20,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Text(
              '${'عساك بخير يا'.tr} ${UserPreferences.getUserName()}   ${Emojis.emotion_yellow_heart} ',
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 119,
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
                  calculateBirthDay();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppbarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25), // Adjust the radius as needed
                  ),
                ),
                child: Text(
                  'شكرا'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  changeNameDialog() {
    return Get.defaultDialog(
        titlePadding: const EdgeInsets.all(30),
        title: welTitle(),
        textConfirm: 'تغيير'.tr,
        confirmTextColor: Colors.black,
        radius: 20,
        onConfirm: () async {
          AuthController.userName = changeNameController.value.text.trim();
          userName.value = changeNameController.value.text.trim();
          UserPreferences.setUserName(changeNameController.value.text.trim());
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
        },
        content: Form(
          child: CustomTextFormField(
            controller: changeNameController,
            labelText: 'إسمك'.tr,
            onChanged: (String? val) {
              changeNameController.text = val!;
            },
            validator: (String? val) {
              return null;
            },
          ),
        ));
  }

  alarmsDialog() {
    return Get.defaultDialog(
        title: "المنبة",
        textConfirm: "حسنا",
        confirmTextColor: Colors.white,
        radius: 20,
        onConfirm: () async {
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
        },
        content: const Text("سيتوفر قريبا!"));
  }

  changeBirthDateDialog() {
    return Get.defaultDialog(
        titlePadding: const EdgeInsets.all(20),
        title: welTitle(),
        textConfirm: 'تغيير'.tr,
        confirmTextColor: Colors.black,
        radius: 20,
        onConfirm: () async {
          UserPreferences.setBirthdate(
              changeBirthDateController.value.text.trim());
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
        },
        content: Form(
          child: Center(
              child: TextField(
            controller: changeBirthDateController,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText:
                    "عيد ميلاد الكتكوت امتا ${Emojis.smile_partying_face}"),
            readOnly: true,
            onTap: () async {},
          )),
        ));
  }

  addGiftsImages() async {
    Resource<GiftImageModel> response = await apiService.getGidtImages();
    if (response.status == Status.SUCCESS) {
      giftImages.clear();
      giftImages.addAll(response.data!.wheel!.map((e) => e.url).toList());
      UserPreferences.sharedPreferences.setString("giftImages", giftImages[0]);
    } else {
      giftImages.add(
          UserPreferences.sharedPreferences.getString("giftImages") ?? "1.png");
    }
  }

  getLang() async {
    if (UserPreferences.getLanguage() == true /*lang.value == false*/) {
      Get.updateLocale(const Locale('en', 'US'));
      DataService.box.write('lang', "Locale('en','US')");
      lang.value = true;
      UserPreferences.setLang(false);
    } else if (UserPreferences.getLanguage() == false /*lang.value == true*/) {
      Get.updateLocale(const Locale('ar', 'EG'));
      UserPreferences.setLang(true);
      DataService.box.write('lang', "Locale('ar','EG')");
      lang.value = false;
    }
  }

  void calculateBirthDay() async {
    var birthDateString = UserPreferences.getBirthdate();

    if (birthDateString.isEmpty) {
      print("Birth date is not set or invalid.");
      return;
    }

    DateTime dateNow = DateTime.now();
    DateTime birthDate;

    try {
      birthDate = DateFormat("yyyy-MM-dd").parse(birthDateString);
    } catch (e) {
      print("Error parsing birth date: $e");
      return;
    }

    DateTime birthDateCurrentYear =
        DateTime(dateNow.year, birthDate.month, birthDate.day);
    var remainMill = dateNow.millisecondsSinceEpoch -
        birthDateCurrentYear.millisecondsSinceEpoch;

    print('calculateBirthDay = remainMill = $remainMill');
    if (remainMill > 0) {
      var remainDays = Duration(milliseconds: remainMill).inDays;
      print('calculateBirthDay = remainDays = $remainDays');

      if (remainDays < 0) return;
      if (remainDays == 0) {
        var message = "remain_${remainDays}_days_msg".tr;
        showBirthDayView(message);
        birthDayDialog();
      }
    }
  }

  void showBirthDayView(String msg) {
    AwesomeNotifications().setChannel(NotificationChannel(
        channelKey: "birth_date_notification",
        channelName: "BirthDate",
        channelDescription: "BirthDate notification"));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'birth_date_notification',
          title: "birth_date_title".tr,
          body: msg,
          actionType: ActionType.Default,
          criticalAlert: true),
    );
  }

  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'تطبيق كتكوتي هدفه دعمك ومنحك طاقة إيجابية يحتوي علي منبه مُزود بنغمات مُلهمة هتشجعك تنجز مهام يومك بكل نشاط ، وسلسلة شاملة للتغيير وبرطمان سعادة إلكتروني وركن للفضفضة حمل التطبيق من هنا 👇 \n https://play.google.com/store/apps/details?id=com.katkoty.app',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  void onSharePressed(String message) {
    Share.share("$message\n تم النسخ من تطبيق كتكوتي 🐥");
  }

  @override
  void onInit() {
    super.onInit();
    //final UserFadfdaController fc = Get.put(UserFadfdaController());
    // fc.fetchData();
    getQuotes();
    getShok();
    getWans();
    welcomeDialog();
    // setUpNotification();
    setupNotification();
    // refreshAlarms();
    calculateBirthDay();
  }
}
