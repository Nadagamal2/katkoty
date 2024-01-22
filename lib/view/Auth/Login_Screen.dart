import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/view/Auth/signUp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:katkoty/utils/color.dart';
import '../../controller/auth_controller.dart';
import '../../controller/login_controller.dart';
import '../../service/shared_preference/user_preference.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _controller = Get.put(LoginController());

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  final userData2 = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'مرحباَ بك في تطبيق كتكوتي',
              style: TextStyle(
                  fontSize: 21,
                  color: AppbarColor,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                _controller.uemail.value = value;
              },

              keyboardType:
              TextInputType.emailAddress, // Use email keyboard type
              decoration:   InputDecoration(
                fillColor:  Colors.grey.shade200,
                filled: true,
                labelText: 'البريد الإلكتروني', // Customize the label text
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))), // You can customize the border
              ),
              // Add validation logic here if needed
            ),
            const SizedBox(
                height:
                10), // Add some spacing between the email and password fields
            TextFormField(
              onChanged: (value) {
                _controller.upasword.value = value;
              },
              keyboardType: TextInputType.text,
              obscureText: true, // This hides the password input
              decoration:   InputDecoration(
                fillColor:  Colors.grey.shade200,
                filled: true,
                labelText: 'كلمة المرور', // Customize the label text
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(15))), // You can customize the border
              ),
              // Add validation logic here if needed
            ),

            SizedBox(
              height: 15,
            ),
            Text(
              'أو',
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 20,
              endIndent: 20,
              indent: 20,
              color: Colors.grey.shade300,
            ),
            GestureDetector(
              onTap: () async {
                await _controller.signInWithGoogle();
                UserPreferences.setIsLoggedIn(true);
                userData2.write('isLogged', true);
              },
              child: Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(139, 158, 158, 158),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/google.png'),
                      const SizedBox(
                        width: 12,
                      ),
                      const FittedBox(
                        child: Text(
                          'تسجيل الدخول بواسطة جوجل',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                print('ok');
                if (_controller.uemail.value != '' &&
                    _controller.upasword.value != '') {
                  _controller.signInWithEmailandPassword();
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                width: double.infinity,
                height: 50,
                child: const Center(child: Text('تسجيل الدخول')),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    _launchURL("https://sites.google.com/view/katkoty/home");
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '  بالتسجيل أنت توافق على',
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                        const TextSpan(
                          text: '  سياسة الخصوصية',
                          style: TextStyle(
                              fontSize: 16,
                              // decoration: TextDecoration.underline,
                              color: AppbarColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                     Get.to(SignupScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ليس لديك حساب ؟ ',
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                        const TextSpan(
                          text: 'إنشاء حساب',
                          style: TextStyle(
                              fontSize: 16,
                              // decoration: TextDecoration.underline,
                              color: AppbarColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
