import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/AskYouerSelf/widget/buttons_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/treausers_controller.dart'; // Change the import path
import '../../../utils/color.dart';
import '../../El_Azqar/widget/custom_utton.dart';
import 'check_box_widget.dart'; // Fix the import name

class TreasuresWidget extends StatefulWidget {
  const TreasuresWidget({Key? key}) : super(key: key);

  @override
  State<TreasuresWidget> createState() => _TreasuresWidgetState();
}

class _TreasuresWidgetState extends State<TreasuresWidget> {
  final TreasuresController treasuresController =
      Get.put(TreasuresController());
  final TreasuresStorage treasuresStorage = TreasuresStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: "ماذا أنجزت اليوم يا كتكوتي ؟"
              .text
              .color(Get.isDarkMode ? Colors.white : buttons)
              .size(18)
              .fontWeight(FontWeight.bold)
              .make(),
        ),
        20.heightBox,
        ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: treasuresController.treasuresList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final treasure = treasuresController.treasuresList[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: treasure.name.text
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
                        treasuresController.updateReadStatus(index, option1);
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
        20.heightBox,
        CustomTextButton(
          width: 109,
          height: 35,
          borderRadius: 21,
          text: "حفظ",
          onPressed: () {
            int readCount = treasuresController.treasuresList
                .where((treasure) => treasure.read)
                .length;
            double percentage =
                readCount / treasuresController.treasuresList.length * 100;
            String message =
                'لقد قمت بـ $readCount من ${treasuresController.treasuresList.length} الكنوز. ';
            if (percentage == 100) {
              message += 'ممتاز! لقد أكملت جميع الكنوز. استمر في العمل الجيد!';
            } else if (percentage > 50) {
              message +=
                  'جيد جدًا! لقد أكملت ${percentage.toInt()}% من الكنوز. استمر في العمل الجيد!';
            } else if (percentage > 0) {
              message +=
                  'أحسنت! لقد أكملت ${percentage.toInt()}% من الكنوز. حاول تحقيق تقدم أكبر في المرات القادمة!';
            } else {
              message +=
                  'لم تحقق أي تقدم بعد. حاول البدء في أكمال بعض الكنوز وسترى التحسن!';
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
