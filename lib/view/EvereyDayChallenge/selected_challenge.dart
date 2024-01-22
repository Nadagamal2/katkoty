import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/utils/color.dart';

import '../El_Azqar/widget/custom_appBar.dart';
import 'challenge_controller.dart';

class ChallengeDetailsPage extends StatelessWidget {
  final String challenge;
  final String challenge2;
  final int challengeIndex;

  ChallengeDetailsPage({
    super.key,
    required this.challenge,
    required this.challengeIndex,
    required this.challenge2,
  });

  final ChallangeController _controller = Get.find<ChallangeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'كل يوم تحدي جديد'.tr,
          onPressed: () {
            Get.back();
          }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                backgroundColor:
                                    (_controller.isChallengeCompleted(
                                                challengeIndex) &&
                                            !_controller.isinChallengeCompleted(
                                                challengeIndex))
                                        ? AppbarColor
                                        : Colors.grey[200],
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.checkmark,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_controller
                                    .isChallengeCompleted(challengeIndex)) {
                                  _controller
                                      .removecompleteChallenge(challengeIndex);
                                  _controller.removeincompleteChallenge(
                                      challengeIndex);
                                } else {
                                  _controller.completeChallenge(challengeIndex);
                                  _controller.removeincompleteChallenge(
                                      challengeIndex);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  backgroundColor:
                                      _controller.isinChallengeCompleted(
                                              challengeIndex)
                                          ? Colors.redAccent
                                          : Colors.grey[200],
                                ),
                                child: const Icon(
                                  CupertinoIcons.clear,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_controller
                                      .isinChallengeCompleted(challengeIndex)) {
                                    _controller.removeincompleteChallenge(
                                        challengeIndex);
                                  } else {
                                    _controller
                                        .incompleteChallenge(challengeIndex);
                                    _controller.removecompleteChallenge(
                                        challengeIndex);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 9,
                    child: Text(
                      challenge,
                      maxLines: null,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                backgroundColor: (_controller
                                            .isChallenge2Completed(
                                                challengeIndex) &&
                                        !_controller.isinChallengeCompleted2(
                                            challengeIndex))
                                    ? AppbarColor
                                    : Colors.grey[200],
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.checkmark,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_controller
                                    .isChallenge2Completed(challengeIndex)) {
                                  _controller
                                      .removecompleteChalleng2(challengeIndex);
                                  _controller.removeincompleteChallenge2(
                                      challengeIndex);
                                } else {
                                  _controller
                                      .completeChallenge2(challengeIndex);
                                  _controller.removeincompleteChallenge2(
                                      challengeIndex);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  backgroundColor:
                                      _controller.isinChallengeCompleted2(
                                              challengeIndex)
                                          ? Colors.redAccent
                                          : Colors.grey[200],
                                ),
                                child: const Icon(
                                  CupertinoIcons.clear,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_controller.isinChallengeCompleted2(
                                      challengeIndex)) {
                                    _controller.removeincompleteChallenge2(
                                        challengeIndex);
                                  } else {
                                    _controller
                                        .incompleteChallenge2(challengeIndex);
                                    _controller.removecompleteChalleng2(
                                        challengeIndex);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 9,
                    child: Text(
                      challenge2,
                      maxLines: null,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      backgroundColor: AppbarColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21))),
                  onPressed: () {
                    _controller.completeChallenge(challengeIndex);
                    _controller.completeChallenge2(challengeIndex);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      'حفظ'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
