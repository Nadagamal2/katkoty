/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/add_comments.dart';
import '../controller/user_post_controller.dart';
import '../db/model/post_model.dart';
import '../service/services/post_like.dart';
import '../service/shared_preference/user_preference.dart';
import '../utils/strings.dart';
import 'El_Azqar/widget/custom_dialog.dart';
import 'Emtnan/widget/comment_screen.dart';
import 'Emtnan/widget/social_buttons.dart';

class EmtnanPostOne extends StatefulWidget {
  const EmtnanPostOne({super.key, this.post});
  final Post? post;

  @override
  State<EmtnanPostOne> createState() => _EmtnanPostOneState();
}

class _EmtnanPostOneState extends State<EmtnanPostOne> {
  @override
  Widget build(BuildContext context) {
     final AddCommentsController commentdi = Get.put(AddCommentsController());
    final PostsController controller = Get.put(PostsController());

    final GetStorage box = GetStorage();

    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogemtnan') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            contant: const Text(
          emtnanWelcome,
          textAlign: TextAlign.center,
        ));
      });
      box.write('hasShownDialogemtnan', true);
    }

    return Column(
      children: [
GetBuilder<PostsController>(
            init: PostsController(),
            builder: (controller) {
              List emtnanposts = controller.posts.reversed.toList();
              if (emtnanposts.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        int reversedIndex = emtnanposts.length - index - 1;
                        Post upost = emtnanposts[reversedIndex];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PostDetailsPage(
                                  post: emtnanposts[reversedIndex],
                                ));
                          },
                          child: userspost(
                            postidforlike: emtnanposts[reversedIndex].id,
                            context: context,
                            post: emtnanposts[reversedIndex],
                            pressComment: () {
                              commentdi.showCommentDialog(
                                post_id:
                                    emtnanposts[reversedIndex].id.toString(),
                                user_id: UserPreferences.getUserid(),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: emtnanposts.length,
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }
  Widget userspost({
    required BuildContext context,
    required Post post,
    required int postidforlike,
    //   required VoidCallback pressLike,
    required VoidCallback pressComment,
  }) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    10.heightBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(post.user.photo),
                        ),
                        5.widthBox,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  FittedBox(
                                    child: Text(
                                      ' ${post.user.fullName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      post.createdAt.timeAgo(),
                                      style: const TextStyle(
                                        color: Color(0xffA3A3A3),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        maxLines: null,
                        softWrap: true,
                        post.text,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(),
                    PostActionsRow(
                      postidforlike: post.id,
                      likecount: post.likecount,
                      pressLike: () async {
                        final PostLikeController postOnecontroller = Get.find();
                        postOnecontroller.setLike(postidforlike, '1');
                      },
                      pressComment: pressComment,
                      pressShare: () {
                        final String postContent = post.text;
                        onSharePressed(postContent);
                      },
                      commentsCount: post.commentsCount,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  void onSharePressed(String message) {
    Share.share("$message\n تم النسخ من تطبيق كتكوتي 🐥");
  }
}
 */