import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../controller/List_pray_controller.dart';
import '../../../utils/color.dart';
import '../../../utils/list.dart';
import '../../El_Azqar/widget/custom_utton.dart';
import 'buttons_dialog.dart';
import 'check_box_widget.dart';

class ListOfPray extends StatefulWidget {
  const ListOfPray({super.key});

  @override
  State<ListOfPray> createState() => _nameState();
}

class _nameState extends State<ListOfPray> {
  final PrayerController prayerController = Get.put(PrayerController());
  final PrayerStorage prayerStorage = PrayerStorage();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Align(
            alignment: Alignment.topRight,
            child: "الصلاة دائماً مقرونة بالفلاح فكيف يفلح من لا يُصلي! "
                .text
                .color(Get.isDarkMode ? Colors.white : buttons)
                .fontWeight(FontWeight.w700)
                .align(TextAlign.center)
                .maxLines(2)
                .make(),
          ),
        ),
        20.heightBox,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: "صلوات اليوم"
                .text
                .color(Get.isDarkMode ? Colors.white : buttons)
                .size(18)
                .fontWeight(FontWeight.bold)
                .make(),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prayers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final prayer = prayerController.prayerList[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: prayers[index]
                        .name
                        .text
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
                    option1Text: 'صليت',
                    option2Text: 'لم اٌصلِ',
                    showText: index == 0 ? true : false,
                    onChanged: (option1, option2) {
                      setState(() {
                        prayerController.updateReadStatus(index, option1);
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
        CustomTextButton(
          width: 109,
          height: 35,
          borderRadius: 21,
          text: "حفظ",
          onPressed: () {
            int prayedCount = prayerController.prayerList
                .where((treasure) => treasure.read)
                .length;
            double percentage =
                prayedCount / prayerController.prayerList.length * 100;
            String message =
                'لقد صليت $prayedCount من ${prayerController.prayerList.length} صلوات. ';
            if (percentage == 100) {
              message += 'ممتاز! لقد صليت كل الصلوات. استمر في العمل الجيد!';
            } else if (percentage > 50) {
              message +=
                  'جيد جدًا! لقد صليت ${percentage.toInt()}% من الصلوات. استمر في العمل الجيد!';
            } else {
              message +=
                  'لا يزال هناك الكثير للعمل. حاول الحفاظ على المزيد من الصلوات وسترى التحسن!';
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the value as needed
                  ),
                  title:
                      Center(child: Text("  الأنجاز ${percentage.toInt()}%")),
                  content: Text(message),
                  actions: const [
                    Center(
                        child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ButtonDialog(),
                    ))
                  ],
                );
              },
            );
          },
          testSize: 14,
          color: Colors.white,
        ),
      ],
    );
  }
}
