import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/Auth/Login_Screen.dart';
import 'package:katkoty/view/Emtnan/emtnan_post.dart';
import 'package:katkoty/view/Emtnan/emtnan_users.dart';

import 'widget/department_card.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              width: 185,
              height: 148,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: Get.height/0.419,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 30,
                runSpacing: 30,
                children: [
                  DepartmentCard(
                    imagepath: 'assets/images/ايقونه امتنان.png',
                    depname: 'امتنان',
                    action: () => Get.to(() => const  EmtnanPost()),
                  ),
                  DepartmentCard(
                    imagepath: 'assets/images/ايقونه حاسب نفسك.png',
                    depname: 'حساب نفسك',
                    action: () => Get.to(() => const EmtnanUsers()),
                  ),
                  DepartmentCard(
                    imagepath: 'assets/images/ايقونه تحدي كل يوم.png',
                    depname: 'كل يوم تحدي جديد',
                    action: () => Get.to(() => const EmtnanUsers()),
                  ),
                  DepartmentCard(
                    imagepath: 'assets/images/ورد الذكر.png',
                    depname: 'ورد الذكر',
                    action: () => Get.to(() =>  LoginScreen()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}