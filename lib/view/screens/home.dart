import 'package:confetti/confetti.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:katkoty/controller/get_fadfda_controller.dart';
import 'package:katkoty/controller/home_controller.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/view/Emtnan/emtnan_post.dart';
import 'package:katkoty/view/screens/menu.dart';
import 'package:katkoty/view/screens/new_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../packages/alarm/screens/alarms_screen/alarms_list_screen.dart';
import '../../utils/images.dart';
import '../AskYouerSelf/ask_home.dart';
import '../El_Azqar/mesbaha.dart';
import '../El_Azqar/widget/custom_dialog.dart';
import '../Emtnan/EmtnanFull.dart';
import '../EvereyDayChallenge/challengeDay.dart';
import '../widgets/bnner_ad.dart';
import '../widgets/home_card_button.dart';
import 'courses_list_screen.dart';
import 'notes.dart';
import 'notifications/notification_screen.dart';

class Home extends GetWidget<HomeController> {
    Home({Key? key}) : super(key: key);

  // final adManager = AdManager();
  static RxBool isLightTheme = false.obs;
  final UserFadfdaController fc =
  Get.put(UserFadfdaController());
  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogewlcom') ?? false;
    if (!hasShownDialoge) {
      {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          myDialogController.showDefaultDialog(
            title: "لقد تم تسجيل الدخول بنجاح",
            contant: const Text(
              ' بفكرك إنك تقدر تغير اسمك لأي اسم دلع بتحبه من إعدادت التطبيق وكمان تقدر تضيف تاريخ يوم ميلادك عشان تحتفل بيه مع كتكوتي 🥳',
              textAlign: TextAlign.center,
            ),
          );
        });
      }
      box.write('hasShownDialogewlcom', true);
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('كتكوتي'.tr),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Get.to(() => NotificationScreen()),
                  child: Image.asset(
                    'assets/images/icons/notification.png',
                    fit: BoxFit.fitWidth,
                    width: 37,
                    height: 37,
                  ),
                ),
              )
            ],
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {print(Get.previousRoute);
                  Get.to(() => Menu());  }, icon: Icon(Icons.menu,color: Colors.black,),

                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: ClipOval(
                //       child: Image.network(
                //         UserPreferences.getUserpic(),
                //         fit: BoxFit.fitHeight,
                //       )),
                // ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardButton(
                            image: fortunewheel,
                            text: 'عجلة السعادة'.tr,
                            scale: 2,
                            onPressed: () {
                              controller.spinningWheel();
                            },
                          ),
                          CardButton(
                            image: messageLove,
                            scale: 7,
                            text: 'رسالة لقلبك'.tr,
                            onPressed: () {
                              if (controller.quotes.isEmpty) {
                                controller.getQuotes();
                              } else {
                                controller.quotesDialog();
                              }
                            },
                          ),
                          CardButton(
                            image: challange,
                            text: 'تحدي كل يوم'.tr,
                            scale: 2,
                            onPressed: () {
                              Get.to(() => ChallangeDay());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardButton(
                            image: askYourSelf,
                            text: 'حاسب نفسك'.tr,
                            scale: 2,
                            onPressed: () {
                              Get.to(() => const AskYourSelf());
                            },
                          ),
                          CardButton(
                            image: emtanan,
                            text: 'امتنان'.tr,
                            scale: 2,
                            onPressed: () {
                              Get.to(() => const EmtnanFull());
                            },
                          ),
                          CardButton(
                            image: improve,
                            text: 'improve_yourself'.tr,
                            scale: 5,
                            onPressed: () async {
                              // adManager.loadInterstitialAd();
                              Get.to(() => const CoursesList());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardButton(
                            image: elzker,
                            text: 'وِرد الذكر'.tr,
                            scale: 2,
                            onPressed: () {
                              Get.to(() => const Mesbaha());
                            },
                          ),
                          CardButton(
                            image: tasks,
                            text: 'المهام'.tr,
                            scale: 3,
                            onPressed: () {
                              Get.to(() => NewTaskScreen());
                              controller.giftOpen;
                            },
                          ),
                          CardButton(
                            image: fadfda,
                            text: 'فضفضة'.tr,
                            scale: 7,
                            onPressed: () async {


                           Get.to(() => Notes());


                              // var request = http.Request(
                              //     'GET',
                              //     Uri.parse(
                              //         'https://katkoty-app.com/admin/api/get_fadfada.php?user_id=18'));
                              //
                              // http.StreamedResponse response =
                              //     await request.send();
                              //
                              // if (response.statusCode == 200) {
                              //   print(await response.stream.bytesToString());
                              // } else {
                              //   print(response.reasonPhrase);
                              // }
                              // print('------------');
                              // print(fc.fadfda[0].text);
                              //
                              // Get.toNamed('note');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // CardButton(
                          //   image: alarm,
                          //   text: 'المنبه'.tr,
                          //   scale: 2,
                          //   onPressed: () async {
                          //     await DisableBatteryOptimization
                          //         .showDisableBatteryOptimizationSettings();
                          //     Get.to(() => const AlarmsListScreen());
                          //   },
                          // ),
                          CardButton(
                            image: wanes,
                            text: 'وَنَس'.tr,
                            scale: 7,
                            onPressed: () {
                              if (controller.wans.isEmpty) {
                                controller.getWans();
                              } else {
                                controller.wansDialog();
                              }
                            },
                          ),
                          CardButton(
                            image: love,
                            text: 'الشوق يا سكر'.tr,
                            scale: 8,
                            onPressed: () async {
                              if (controller.shok.isEmpty) {
                                controller.getShok();
                              } else {
                                controller.shokDialog();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //  bottomNavigationBar: const BannerAdWidget(),
        ),
        ConfettiWidget(
          confettiController: controller.showController,
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 50,
          gravity: 0.5,
          createParticlePath: (size) {
            final path = Path();
            path.addOval(
                Rect.fromCenter(center: Offset.zero, width: 20, height: 20));
            return path;
          },
        )
      ],
    );
  }
}

saveThemeStatus(bool val) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var newval = pref.setBool('theme', val);
}
