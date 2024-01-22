import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/Elazkar_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/color.dart';
import '../../El_Azqar/widget/custom_utton.dart';
import 'buttons_dialog.dart';
import 'check_box_widget.dart';

class ListOfAzkar extends StatefulWidget {
  const ListOfAzkar({Key? key}) : super(key: key);

  @override
  State<ListOfAzkar> createState() => _ListOfAzkarState();
}

class _ListOfAzkarState extends State<ListOfAzkar> {
  final ElazkarController elazkarController = Get.put(ElazkarController());
  final ElazkarStorage elazkarStorage = ElazkarStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Align(
            alignment: Alignment.topRight,
            child: "ذكر الله يلين القلب ويُصلحه وبه يصلح العبد"
                .text
                .color(Get.isDarkMode ? Colors.white : buttons)
                .maxLines(1)
                .fontWeight(FontWeight.w700)
                .make(),
          ),
        ),
        20.heightBox,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: "اذكار اليوم "
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
          itemCount: elazkarController.elazkarTwoList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemBuilder: (context, index) {
            final elazkarS = elazkarController.elazkarTwoList[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: elazkarS.name.text
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
                    option2Text: 'لم افعل ',
                    showText: index == 0 ? true : false,
                    onChanged: (option1, option2) {
                      setState(() {
                        elazkarController.updateReadStatus(index, option1);
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
          onPressed: () {
            int readCount = elazkarController.elazkarTwoList
                .where((elazkar) => elazkar.read)
                .length;
            double percentage =
                readCount / elazkarController.elazkarTwoList.length * 100;
            String message = '';
            if (percentage == 100) {
              message = 'ممتاز! لقد قمت بقراءة جميع الأذكار بنجاح.';
            } else if (percentage > 50) {
              message =
                  'جيد جدًا! لقد قرأت ${percentage.toInt()}% من الأذكار. استمر في العمل الجيد!';
            } else if (percentage > 0) {
              message =
                  'أحسنت! لقد قرأت ${percentage.toInt()}% من الأذكار. حاول تحقيق تقدم أكبر في المرات القادمة!';
            } else {
              message =
                  'لم تقم بقراءة أي أذكار بعد. حاول البدء في قراءة بعض الأذكار وسترى التحسن!';
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
                    child: ButtonDialog(),
                  ))],
                );
              },
            );
          },
          color: Colors.white,
          text: 'حفظ',
          testSize: 13,
        ),
      ],
    );
  }
}
