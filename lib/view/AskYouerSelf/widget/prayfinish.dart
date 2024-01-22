import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/view/El_Azqar/widget/custom_utton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/finish_praye_controller.dart';

import 'buttons_dialog.dart';
import 'check_box_widget.dart';

class PrayFinishWidget extends StatefulWidget {
  const PrayFinishWidget({Key? key}) : super(key: key);

  @override
  State<PrayFinishWidget> createState() => _PrayFinishWidgetState();
}

class _PrayFinishWidgetState extends State<PrayFinishWidget> {
  final FinishPrayController finishPrayerController =
      Get.put(FinishPrayController());
  final FinishPrayStorage finishPrayerStorage = FinishPrayStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: "السُنن"
                .text
                .color(Get.isDarkMode ? Colors.white : buttons)
                .size(18)
                .fontWeight(FontWeight.bold)
                .make(),
          ),
        ),
        Obx(() => ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: finishPrayerController.finishPrayerList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 2),
              itemBuilder: (context, index) {
                final finishPrayer =
                    finishPrayerController.finishPrayerList[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: finishPrayer.name.text
                            .color(Get.isDarkMode ? Colors.white : buttons)
                            .size(16)
                            .fontWeight(FontWeight.w500)
                            .make(),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: CheckboxRow(
                        option1Text: 'فعلت',
                        option2Text: 'لم أفعل',
                        showText: index == 0 ? true : false,
                        onChanged: (option1, option2) {
                          setState(() {
                            finishPrayerController.updateReadStatus(
                                index, option1);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            )),
        /* Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                " النسبة المحفوظة لختم صلوات اليوم: ${finishPrayerController.savedPercentage.toInt()}%"
                    .text
                    .color(buttons)
                    .size(18)
                    .fontWeight(FontWeight.w700)
                    .make(),
          ),
        ), */
        CustomTextButton(
          width: 109,
          height: 35,
          borderRadius: 21,
          onPressed: () {
            int readCount = finishPrayerController.finishPrayerList
                .where((finishPrayer) => finishPrayer.read)
                .length;
            double percentage = readCount /
                finishPrayerController.finishPrayerList.length *
                100;
            String message =
                'لقد قمت $readCount  من سنن ${finishPrayerController.finishPrayerList.length} صلوات. ';
            if (percentage == 100) {
              message +=
                  'ممتاز! لقد قرأت أذكار كل الصلوات. استمر في العمل الجيد!';
            } else if (percentage > 50) {
              message +=
                  'جيد جدًا! لقد قمت ${percentage.toInt()}% من سنن. استمر في العمل الجيد!';
            } else {
              message +=
                  'لا يزال هناك الكثير للعمل. حاول المتابعه في سنن الصلوات وسترى التحسن!';
            }

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title:
                      Center(child: Text("  الأنجاز ${percentage.toInt()}%")),
                  content: Text(message),
                  actions: const [Center(child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(child: ButtonDialog()),
                  ))],
                );
              },
            );
          },
          testSize: 12,
          color: Colors.white,
          text: 'حفظ',
        ),
      ],
    );
  }
}
