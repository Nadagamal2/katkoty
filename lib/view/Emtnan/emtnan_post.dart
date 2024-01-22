import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/controller/add_comments.dart';
import 'package:katkoty/controller/user_post_controller.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/view/Emtnan/widget/SavePost.dart';
import 'package:katkoty/view/Emtnan/widget/comment_screen.dart';
import 'package:katkoty/view/Emtnan/widget/DeletePost.dart';
import 'package:katkoty/view/Emtnan/widget/social_buttons.dart';
import 'package:katkoty/view/screens/home.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../db/model/post_model.dart';
import '../../service/services/post_like.dart';
import '../../utils/strings.dart';
import '../El_Azqar/widget/custom_dialog.dart';
import 'package:http/http.dart' as http;
class EmtnanPost extends StatefulWidget {
  final Post? post;

  const EmtnanPost({Key? key, this.post}) : super(key: key);

  @override
  State<EmtnanPost> createState() => _EmtnanPostState();
}
final userData2 = GetStorage();

class _EmtnanPostState extends State<EmtnanPost> {
 // final PostLikeController postOnecontroller = Get.put(PostLikeController());
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
        SizedBox(
          height:550,
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.refreshPosts();
            },
            child: GetBuilder<PostsController>(
                init: PostsController(),
                builder: (controller) {
                  List emtnanposts = controller.posts.reversed.toList();
                  if (emtnanposts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        int reversedIndex = emtnanposts.length - index - 1;
                        Post upost = emtnanposts[reversedIndex];
                        return GestureDetector(
                          onTap: () {
                            print(emtnanposts[reversedIndex].id);
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

                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: emtnanposts.length,
                    );
                  }
                }),
          ),
        ),
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
                              // if (post.user.id == userData2.read('id'))
                              InkWell(
                                  onTap: (){
                                    final PostLikeController postOnecontroller = Get.find();
                                    postOnecontroller.delete(
                                      '${post.user.id}','${post.id}'

                                    );

                                  },
                                  child: Icon(Icons.delete)),
                           //     Delete2Post(postId: post.id.toString())
                              // else
                              //   const SavePost(),
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
                        postOnecontroller.setLike(post.id, '${post.likecount}');
                        print('post.id${post.id}');
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
