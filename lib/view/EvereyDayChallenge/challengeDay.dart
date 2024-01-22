import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/view/EvereyDayChallenge/addChallengeDay.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/strings.dart';
import '../El_Azqar/widget/challenge_container.dart';
import '../El_Azqar/widget/custom_appBar.dart';
import '../El_Azqar/widget/custom_dialog.dart';
import '../El_Azqar/widget/custom_utton.dart';
import 'challenge_controller.dart';
import 'our_challange.dart';
import 'selected_challenge.dart';

class ChallangeDay extends GetView<ChallangeController> {
  ChallangeDay({Key? key}) : super(key: key);
  @override
  final ChallangeController controller = Get.put(ChallangeController());
  final GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final MyDialogController myDialogController = Get.put(MyDialogController());

    bool hasShownDialog = box.read<bool>('hasShownDialogchallenge') ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!hasShownDialog) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          myDialogController.showDefaultDialog(
              contant: const Text(
            challengewelcome,
            textAlign: TextAlign.center,
          ));
        });
        box.write('hasShownDialogchallenge', true);
      }

      controller.loadCompletedChallenges();
    });
    return Scaffold(
      appBar: CustomAppBar(
          title: 'كل يوم تحدي جديد'.tr,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            20.heightBox,
            Row(
              children: [
                const Spacer(),
                CustomTextButton(
                  color: Colors.black,
                  borderRadius: 10,
                  text: 'بدء من جديد'.tr,
                  onPressed: () {
                    controller.resetChallenges();
                  },
                  width: 160,
                  height: 48,
                  testSize: 16,
                ),
                const Spacer(),
                CustomTextButton(
                  borderRadius: 10,
                  color: Colors.black,
                  text: 'إضافة تحدى جديد'.tr,
                  onPressed: () {
                    Get.to(() => const AddChallange());
                  },
                  width: 160,
                  height: 48,
                  testSize: 16,
                ),
                const Spacer(),
              ],
            ),
            20.heightBox,
            SizedBox(
              height: Get.height * 0.8,
              child: GetBuilder<ChallangeController>(
                builder: (controller) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    shrinkWrap: true,
                    itemCount: MyChallange.weakchallange.length +
                        MyChallange.strongchallange.length +
                        controller.listofUserchallenge.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 120,
                    ),
                    itemBuilder: (context, index) {
                      final isCompleted =
                          controller.isChallengeCompleted(index);
                      final iscompletedch2 =
                          controller.isChallenge2Completed(index);

                      final wChallenges = [
                        ...MyChallange.weakchallange,
                        ...MyChallange.strongchallange,
                        ...controller.listofUserchallenge
                      ];
                      final sChallenges = [
                        ...MyChallange.weakchallange2,
                        ...MyChallange.strongchallange2,
                        ...controller.listofUserstrongchallenge
                      ];
                      final allChallenges = [
                        ...wChallenges,
                        ...sChallenges,
                        ...controller.listofUserchallenge,
                        ...controller.listofUserstrongchallenge
                      ];
                      final challenge = allChallenges[index];
                      final wchallenge = wChallenges[index];
                      final schallenge = sChallenges[index];
                      return GestureDetector(
                        onTap: () {
                          (controller.isChallengeCompleted(index - 1) &&
                                      controller
                                          .isChallenge2Completed(index - 1) ||
                                  index == 0)
                              ? Get.to(() => ChallengeDetailsPage(
                                    challenge: wchallenge,
                                    challenge2: schallenge,
                                    challengeIndex: index,
                                  ))
                              : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: Text(
                                          'لا يمكنك فتح هذا التحدي الأن'.tr),
                                      content: Text(
                                          'اكمل التحديات السابقة أولاً يا كتكوتي'
                                              .tr),
                                      actions: [
                                        Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: AppbarColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('حسناً'.tr,
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                        child: ChallengeBox(
                          isCompleted: isCompleted,
                          imagepath:
                              getImagePath(index, isCompleted, iscompletedch2),
                          challengeday: ((!isCompleted && !iscompletedch2) &&
                                  (!controller
                                          .isChallengeCompleted(index - 1) ||
                                      !controller
                                          .isChallenge2Completed(index - 1)) &&
                                  index != 0)
                              ? Center(
                                  child: Text(
                                    '\n${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : const Text(''),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImagePath(int index, bool isCompleted, bool isCompletedch2) {
    if (index == 0 && (!isCompleted || !isCompletedch2)) {
      return 'assets/images/app_icon.png';
    } else if (isCompleted && isCompletedch2) {
      return 'assets/images/true.png';
    } else if (controller.isChallengeCompleted(index - 1) &&
        controller.isChallenge2Completed(index - 1)) {
      return 'assets/images/app_icon.png';
    } else {
      return 'assets/images/back.png';
    }
  }
}
