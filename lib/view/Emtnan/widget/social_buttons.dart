import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/add_comments.dart';
import '../../../db/model/new_post.dart';
import '../../../service/services/post_like.dart';
import '../../../utils/color.dart';

class PostActionsRow extends StatelessWidget {
  final PostLikeController likeController =  Get.put (PostLikeController());

  final AddCommentsController commentController =
      Get.put(AddCommentsController()) ;
  final VoidCallback pressLike;
  final VoidCallback pressComment;
  final VoidCallback pressShare;
  final int likecount;
  final int commentsCount;
  final int postidforlike;

  PostActionsRow({
    super.key,
    required this.postidforlike,
    required this.pressLike,
    required this.pressComment,
    required this.pressShare,
    required this.likecount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: pressLike,
            icon: Obx(() {

              print(
                  'Inside Icon Obx - isLiked: ${likeController.isLiked.value}');
              return Icon(
                CupertinoIcons.hand_thumbsup,
                size: 20,
                color: likeController.isLiked.value ? Colors.blue : buttons,
              );
            }),
            label: () {
              return FittedBox(
                child: Obx(() => Text(
                      "${likeController.postlikeCount.value + likecount} أعجبني"
                          .tr,
                      //likeController.postlikeCount.value + likecount
                      style: TextStyle(
                        color: Get.isDarkMode ? Colors.white70 : buttons,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              );
            }(),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: pressComment,
            icon: Icon(
              CupertinoIcons.bubble_middle_bottom,
              size: 20,
              color: Get.isDarkMode ? Colors.white70 : buttons,
            ),
            label: FittedBox(
              child: Text(
                "$commentsCount تعليق".tr, // Use commentsCount here
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white70 : buttons,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: pressShare,
            icon: Icon(
              CupertinoIcons.arrowshape_turn_up_right,
              size: 20,
              color: Get.isDarkMode ? Colors.white70 : buttons,
            ),
            label: FittedBox(
              child: Text(
                "مشاركة",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white70 : buttons,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
