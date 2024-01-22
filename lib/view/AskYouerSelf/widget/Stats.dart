import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/Elazkar_controller.dart';
import 'package:katkoty/controller/List_pray_controller.dart';
import 'package:katkoty/controller/elesthfer_controller.dart';
import '../../../controller/finish_praye_controller.dart';
import '../../../controller/quran_controller.dart';
import '../../../controller/treausers_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/color.dart';
import '../../../utils/strings.dart';
import '../../treatment/treatmentOfApathy.dart';
import 'buildStatRow.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PrayerController prayerController = Get.put(PrayerController());
    final FinishPrayController finishPrayerController =
        Get.put(FinishPrayController());
    final QuranController quranController = Get.put(QuranController());
    final ElazkarController elazkarController = Get.put(ElazkarController());
    final ElesthferController elesthferController =
        Get.put(ElesthferController());
    final TreasuresController treasuresController =
        Get.put(TreasuresController());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStatRow("النسبة المحفوظة للصلوات ",
              "${prayerController.savedPercentage.toInt()}%"),
          buildStatRow("النسبة المحفوظة للسنن  ",
              "${finishPrayerController.savedPercentage.toInt()}%"),
          buildStatRow("النسبة المحفوظ للقران",
              "${quranController.savedPercentage.toInt()}%"),
          buildStatRow("النسبة المحفوظ للأذكار",
              "${elazkarController.savedPercentage.toInt()}%"),
          buildStatRow("النسبة المحفوظ للتسابيح ",
              "${elesthferController.savedPercentage.toInt()}%"),
          buildStatRow("النسبة المحفوظة لكنوز الجنة",
              "${treasuresController.savedPercentage.toInt()}%"),
          20.heightBox,
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                seevideo.text
                    .color(Get.isDarkMode ? Colors.white : buttons)
                    .size(15)
                    .fontWeight(FontWeight.w700)
                    .make(),
                10.heightBox,
                InkWell(
                  onTap: () {
                    Get.to(TreatmentApathy());
                  },
                  child: seeVideos.text
                      .color(Get.isDarkMode ? Colors.white : AppbarColor)
                      .size(16)
                      .fontWeight(FontWeight.w700)
                      .make(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
