import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:katkoty/packages/alarm/screens/alarms_screen/alarms_list_screen.dart';
import 'package:katkoty/packages/alarm/screens/edit_alarms/edit_alarm_screen.dart';
import 'package:katkoty/packages/alarm/services/alarm_api_service.dart';
import 'package:katkoty/service/binding.dart';
import 'package:katkoty/service/shared_preference/shared_preference.dart';
import 'package:katkoty/themes/dark_light_theme_file.dart';
import 'package:katkoty/view/Auth/Login_Screen.dart';
import 'package:katkoty/view/Auth/signUp.dart';
import 'package:katkoty/view/Emtnan/emtnan_new_post.dart';
import 'package:katkoty/view/Emtnan/emtnan_post.dart';
import 'package:katkoty/view/EvereyDayChallenge/challenge_controller.dart';
import 'package:katkoty/view/Profile/profile.dart';
import 'package:katkoty/view/screens/about_us_screen.dart';
import 'package:katkoty/view/screens/add_note.dart';
import 'package:katkoty/view/screens/add_task.dart';
import 'package:katkoty/view/screens/add_voice_note.dart';
import 'package:katkoty/view/screens/edit_notes.dart';
import 'package:katkoty/view/screens/home.dart';
import 'package:katkoty/view/screens/menu.dart';
import 'package:katkoty/view/screens/notes.dart';
import 'package:katkoty/view/screens/notifications/fav_notification.dart';
import 'package:katkoty/view/screens/notifications/notification_screen.dart';
import 'package:katkoty/view/screens/quotes.dart';
import 'package:katkoty/view/screens/tasks.dart';
import 'Languages.dart';
import 'controller/Elazkar_controller.dart';
import 'controller/List_pray_controller.dart';
import 'controller/elesthfer_controller.dart';
import 'controller/finish_praye_controller.dart';
import 'controller/quran_controller.dart';
import 'controller/treausers_controller.dart';
import 'service/shared_preference/user_preference.dart';
import 'firebase_options.dart';
import 'view/AskYouerSelf/widget/Stats.dart';
import 'view/AskYouerSelf/widget/Treasures.dart';
import 'view/AskYouerSelf/widget/elazkar.dart';
import 'view/AskYouerSelf/widget/elazkarScreen.dart';
import 'view/AskYouerSelf/widget/list_azkar.dart';
import 'view/AskYouerSelf/widget/list_pray.dart';
import 'view/AskYouerSelf/widget/prayeAndFinsh.dart';
import 'view/AskYouerSelf/widget/prayfinish.dart';
import 'view/AskYouerSelf/widget/quran.dart';
import 'view/El_Azqar/elzeker.dart';
import 'view/El_Azqar/mesbaha.dart';
import 'view/treatment/treatmentOfApathy.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static GlobalKey<NavigatorState> materialkey = GlobalKey();

  static MaterialApp app = MaterialApp(
    navigatorKey: navigatorKey,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await GetStorage.init('myBox');
  await GetStorage.init('box');
  await GetStorage.init('favoriteNotifications');
  await GetStorage.init('challengebox');
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Get.to(() => NotificationScreen());
  });
  await GetStorage.init();
  Get.put(PrayerController());
  Get.put(FinishPrayController());
  Get.put(QuranController());
  Get.put(ElazkarController());
  Get.put(ElesthferController());
  Get.put(TreasuresController());
  // Get.put(NotificationController());
  Get.put(ChallangeController());
  await SharedPrefs.init();
  // fireFakeAlarm();
  await AlarmApiService().initAPIs();
  await Alarm.init();
  getThemeStatus();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = UserPreferences.isLoggedIn();
    final initialScreen = isLoggedIn ?   Home() : Home();
    return GetMaterialApp(
      theme: Get.isDarkMode ? darkTheme : lightTheme,
      darkTheme: darkTheme,
      navigatorKey: Global.navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialBinding: Binding(),
      home: HomePage(),
      locale: UserPreferences.getLanguage() == false
          ? const Locale('en', 'US')
          : const Locale('ar', 'EG'),
      translations: Languages(),
      fallbackLocale: UserPreferences.getLanguage() == false
          ? const Locale('en', 'US')
          : const Locale('ar', 'EG'),
      getPages: [
        GetPage(name: '/LoginScreen', page: () => LoginScreen()),
        GetPage(name: '/home', page: () =>   Home()),
        GetPage(name: '/quotes', page: () => const DrAhmedQuotes()),
        GetPage(name: '/tasks', page: () => const Tasks()),
        GetPage(name: '/add_task', page: () => const AddTask()),
      GetPage(name: '/note', page: () =>  Notes()),
       GetPage(name: '/add_note', page: () =>  AddNote()),
       // GetPage(name: '/Edit_note', page: () =>  EditNote(id: '',)),
        GetPage(name: '/add_voice_note', page: () => const AddVoiceNote()),
        GetPage(name: '/alarm', page: () => const AlarmsListScreen()),
        GetPage(name: '/add_alarm', page: () => const EditAlarmScreen(null)),
        GetPage(name: '/about_app', page: () => const AboutUSScreen()),
        GetPage(name: '/signupscreen', page: () => const SignupScreen()),
        GetPage(name: '/emtnanpost', page: () => const EmtnanPost()),
        GetPage(name: '/EmtnanNewPost', page: () => const EmtnanNewPost()),
        GetPage(name: '/Mesbaha', page: () => const Mesbaha()),
        GetPage(name: '/notification_Screen', page: () => NotificationScreen()),
        GetPage(name: '/favorites_Screen', page: () => FavoritesScreen()),
        GetPage(name: '/profile_Screen', page: () => const ProfileScreen()),
        GetPage(name: '/Elazkar', page: () => const ElazkarScreenMesbha()),
        GetPage(name: '/TreasuresWidget', page: () => const TreasuresWidget()),
        GetPage(name: '/StatsScreen', page: () => const StatsScreen()),
        GetPage(name: '/QuranWidget', page: () => QuranWidget()),
        GetPage(
            name: '/PrayFinishWidget', page: () => const PrayFinishWidget()),
        GetPage(
            name: '/PrayAndFinshPray', page: () => const PrayAndFinshPray()),
        GetPage(name: '/ListOfPray', page: () => const ListOfPray()),
        GetPage(name: '/ListOfAzkar', page: () => const ListOfAzkar()),
        GetPage(name: '/ElazkarScreen', page: () => const ElazkarScreen()),
        GetPage(name: '/ElazkaWidget', page: () => const ElazkaWidget()),
        GetPage(name: '/TreatmentApathy', page: () => const TreatmentApathy()),
        GetPage(name: '/notification_screen', page: () => NotificationScreen()),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userData2 = GetStorage();

  @override
  void initState() {
    super.initState();
    userData2.writeIfNull('isLogged', false);
    userData2.writeIfNull('isLoggedByGoogle', false);
    Future.delayed(Duration.zero, () async {
      checkIfLoged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
        ));
  }

  void checkIfLoged() {
    userData2.read('isLogged')||userData2.read('isLoggedByGoogle')
        ? Get.offAll(Home())
        : Get.offAll(LoginScreen());
  }
}