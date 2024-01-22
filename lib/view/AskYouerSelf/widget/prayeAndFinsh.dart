import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/AskYouerSelf/widget/prayfinish.dart';

import '../../../utils/color.dart';
import '../../../utils/strings.dart';
import '../../El_Azqar/widget/custom_dialog.dart';
import 'list_pray.dart';

class PrayAndFinshPray extends StatelessWidget {
  const PrayAndFinshPray({super.key});
void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final MyDialogController myDialogController =
          Get.put(MyDialogController());
      myDialogController.showDefaultDialog(
        title: '',
        contant: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(ask),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppbarColor),
                minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'مشاهدة الفيديو',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
            ListOfPray(),

           PrayFinishWidget()
      ],  
    );
  }
}