import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/utils/color.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/quran_controller.dart';
import '../../El_Azqar/widget/custom_utton.dart';
import 'buttons_dialog.dart';
import 'check_box_widget.dart';

class QuranWidget extends StatelessWidget {
  final QuranController quranController = Get.put(QuranController());
  final QuranStorage quranStorage = QuranStorage();
  final TextEditingController textFieldController = TextEditingController();

  QuranWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Align(
            alignment: Alignment.topRight,
            child:
                "إذا ذُقت لذة القرآن فاعلم أنك ذقت أعظم لذة،\n فكل وحشة مع القرآن تزول!"
                    .text
                    .maxLines(2)
                    .color(Get.isDarkMode ? Colors.white : buttons)
                    .fontWeight(FontWeight.w700)
                    .align(TextAlign.center)
                    .make(),
          ),
        ),
        30.heightBox,
        Obx(() => ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quranController.quranList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                final quran = quranController.quranList[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: quran.name.text
                            .color(Get.isDarkMode ? Colors.white : buttons)
                            .size(16)
                            .fontWeight(FontWeight.w500)
                            .make(),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: CheckboxRow(
                        option1Text: 'فعلت',
                        option2Text: 'لم أفعل',
                        showText: index == 0 ? true : false,
                        onChanged: (option1, option2) {
                          quranController.updateReadStatus(index, option1);
                        },
                      ),
                    ),
                  ],
                );
              },
            )),
        30.heightBox,
        CustomTextButton(
          width: 109,
          height: 35,
          borderRadius: 21,
          text: 'حفظ',
          onPressed: () {
            int readCount = quranController.quranList
                .where((finishPrayer) => finishPrayer.read)
                .length;
            double percentage =
                readCount / quranController.quranList.length * 100;
            String message =
                'من اجتهد في طاعة الله بحسب استطاعته كان من أهل الجنة، الجنة تستاهل تتعب عشانها، اجتهد في الطاعات ومتكسلش يا كتكوتي ';

            if (percentage == 100) {
              message += 'لقد قرأت جميع الصفحات. ممتاز! استمر في العمل الجيد!';
            } else if (percentage > 50) {
              message +=
                  'لقد قرأت ${percentage.toInt()}% من الصفحات. جيد جدًا! استمر في العمل الجيد!';
            } else if (percentage > 0) {
              message +=
                  'لقد قرأت ${percentage.toInt()}% من الصفحات. أحسنت! حاول تحقيق تقدم أكبر في المرات القادمة!';
            } else {
              message +=
                  'لم تقرأ أي صفحة بعد. حاول البدء في قراءة بعض الصفحات وسترى التحسن!';
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Center(
                      child: Center(
                          child: Text("  الأنجاز ${percentage.toInt()}%"))),
                  content: Text(
                    message,
                  ),
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
          testSize: 12,
          color: Colors.white,
        ),
        /*  20.heightBox,
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                " النسبة المحفوظة لقراءه القرءان: ${quranController.savedPercentage.toInt()}%"
                    .text
                    .color(buttons)
                    .size(20)
                    .fontWeight(FontWeight.w700)
                    .make(),
          ),
        ), */
        /*  TextField(
          controller: textFieldController,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffC7CACD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffC7CACD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffC7CACD)),
            ),
            hintText: "اكتب كل حاجة نفسك تقولها لنفسك يا اشطر كتكوت .....",
          ),
        ),
        20.heightBox,
        CustomTextButton(
          text: "حفظ",
          onPressed: () {},
          testSize: 14,
          color: Colors.white,
        ) */
      ],
    );
  }
}
