import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/controller/home_controller.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_appBar.dart';
import 'package:katkoty/view/Profile/profile.dart';
import 'package:katkoty/view/screens/home.dart';
import 'package:mailto/mailto.dart';
import 'package:open_store/open_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/login_controller.dart';
import '../../service/shared_preference/user_preference.dart';
import '../../utils/color.dart';

class Menu extends StatelessWidget {
  Menu({super.key});
  //static RxBool isLightTheme = false.obs;
  final HomeController controller = Get.find();
  final LoginController logincontroller = Get.put(LoginController());
  final userData2 = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'القائمة',
        onPressed: () => Get.to(() =>   Home()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                //height: 80,
                width: Get.width,
                child: ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => const ProfileScreen());
                    },
                    icon: const Icon(Icons.edit),
                    color: AppbarColor,
                  ),
                  title: Text(
                    userData2.read('isLogged')==true?userData2.read('Name'):UserPreferences.getUserName(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(UserPreferences.getBirthdate()),
                  leading: ClipOval(
                    child: Image.network(
                      userData2.read('isLogged')==true? userData2.read('photo'):UserPreferences.getUserpic(),
                      fit: BoxFit.contain,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(color: AppbarColor),
            ObxValue(
              (data) => SizedBox(
                height: 50,
                child: ListTile(
                  title: Text(
                    'الوضع الليلي'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Icon(
                    Home.isLightTheme.value
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: AppbarColor,
                    trackColor: CupertinoColors.inactiveGray,
                    thumbColor: CupertinoColors.white,
                    value: !Home.isLightTheme
                        .value, 
                    onChanged: (val) {
                      Home.isLightTheme.value =
                          !val; 
                      Get.changeThemeMode(
                        !val
                            ? ThemeMode.dark
                            : ThemeMode
                                .light, 
                      );
                      saveThemeStatus(!val); 
                    },
                  ),
                ),
              ),
              Home.isLightTheme, 
            ),
            const Divider(),
            ListTile(
              title: Text(
                'صفحتنا على الفيسبوك'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.facebook),
              onTap: () {
                launch('https://www.facebook.com/KatKoty74');
              },
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Get.toNamed('about_app');
              },
              child: ListTile(
                title: Text(
                  'عن التطبيق'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.info),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                OpenStore.instance.open(
                  appStoreId: '6446433680',
                  androidAppBundleId: 'com.katkoty.app',
                );
              },
              child: ListTile(
                title: Text(
                  'تقييم التطبيق'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.star_rate),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () async {
                final mailtoLink = Mailto(
                  to: ['asmaasabra6969@gmail.com'],
                  subject: 'اقتراح لتطبيق كتكوتي',
                );
                await launch('$mailtoLink');
              },
              child: ListTile(
                title: Text(
                  'تقديم اقتراح / اتصل بنا'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.message),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                controller.onShare(context);
              },
              child: ListTile(
                title: Text(
                  'مشاركة التطبيق'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(Icons.share),
              ),
            ),
            // const Divider(),
            // ListTile(
            //   title: Text(
            //     'التغيير إلى الإنجليزية'.tr,
            //     style:
            //         const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            //   leading: const Icon(Icons.language_outlined),
            //   onTap: () async {
            //     controller.getLang();
            //     Get.back();
            //   },
            // ),
            const Divider(),
            ListTile(
              title: Text(
                'للتواصل مع المطور'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: () {
                launch(
                    'https://www.facebook.com/profile.php?id=100012157398437');
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'سياسية الخصوصية'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: () {
                launch('https://sites.google.com/view/katkoty/home');
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'تسجيل الخروج '.tr,
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              onTap: () async {
                await logincontroller.signOut();
                userData2.write('isLogged',false );
                userData2.write('isLoggedByGoogle', false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

saveThemeStatus(bool val) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setBool('theme', val);
  Home.isLightTheme.value = val; 
  Get.changeThemeMode(
      val ? ThemeMode.light : ThemeMode.dark); 
}

getThemeStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLight = prefs.getBool('theme') ?? true;
  Home.isLightTheme.value = isLight;
  Get.changeThemeMode(isLight ? ThemeMode.light : ThemeMode.dark);
}
