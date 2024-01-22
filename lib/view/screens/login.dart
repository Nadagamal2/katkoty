import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/widgets/custom_text.dart';
import 'package:katkoty/view/widgets/date_widget.dart';

import '../../controller/auth_controller.dart';
import '../widgets/custom_text_form_field.dart';

class LogIn extends GetWidget<AuthController> {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const CustomText(
          text: 'تسجيل الدخول',
          fontSize: 30,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset('assets/images/app_icon.png')),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'كتكوتي'.tr,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: controller.logInForm,
              child: CustomTextFormField(
                labelText: 'تحب ادلعك ب اي ${Emojis.emotion_red_heart} ؟',
                icon: const Icon(Icons.person),
                onChanged: (value) {
                  controller.name.value = value!.trim();
                },
                validator: (String? value) =>
                    value!.isEmpty ? 'اكتب اسمك الاول' : null,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SelectDateWidget(
              controller.yearController,
              controller.monthController,
              controller.dayController,
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                  onPressed: () async {
                    /*   if (controller.logInForm.currentState?.validate() == true) {
                      var err = await controller.SignInMethod();
                      if (err.isEmpty) {
                        Get.offAllNamed('home');
                      } else {
                        Fluttertoast.showToast(msg: err);
                      }
                    } */
                  },
                  child: Text('أبدأ'.tr)),
            )
          ],
        ),
      ),
    );
  }
}
