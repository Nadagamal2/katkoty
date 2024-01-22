import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/elesthfer_controller.dart';
import '../../../utils/color.dart';
import '../../El_Azqar/widget/custom_utton.dart';
import 'buttons_dialog.dart';
import 'check_box_widget.dart';

class ElazkaWidget extends StatefulWidget {
  const ElazkaWidget({
    super.key,
  });

  @override
  State<ElazkaWidget> createState() => _ElazkaWidgetState();
}

class _ElazkaWidgetState extends State<ElazkaWidget> {
  final ElesthferController elesthferController =
      Get.put(ElesthferController());
  final ElesthferStorage elesthferStorage = ElesthferStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: "التسابيح "
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
          itemCount: elesthferController.elesthferList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final elesthfer = elesthferController.elesthferList[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: elesthfer.name.text
                        .color(Get.isDarkMode ? Colors.white : buttons)
                        .size(16)
                        .maxLines(3)
                        .fontWeight(FontWeight.w500)
                        .make(),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: CheckboxRow(
                    option1Text: 'فعلت',
                    option2Text: 'لم افعل ',
                    showText: index == 0 ? true : false,
                    onChanged: (option1Value, option2Value) {
                      setState(() {
                        elesthferController.updateReadStatus(
                            index, option1Value);
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
            int readCount = elesthferController.elesthferList
                .where((finishPrayer) => finishPrayer.read)
                .length;
            double percentage =
                readCount / elesthferController.elesthferList.length * 100;
            String message = '';
            if (percentage == 100) {
              message = 'ممتاز! لقد قمت بالورد اليومي من التسابيح .';
            } else if (percentage > 50) {
              message =
                  'جيد جدًا! لقد قمت بالتسابيح ${percentage.toInt()}% من الأذكار. استمر في العمل الجيد!';
            } else if (percentage > 0) {
              message =
                  'أحسنت! لقد قمت بالتسابيح ${percentage.toInt()}% من الأذكار. حاول تحقيق تقدم أكبر في المرات القادمة!';
            } else {
              message =
                  'لم تقم بالتسابيح بعد. حاول البدء في الاستغفار وسترى التحسن!';
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
                    )),
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
