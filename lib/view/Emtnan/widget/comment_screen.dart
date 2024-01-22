import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/view/Emtnan/widget/social_buttons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../controller/add_comments.dart';
import '../../../controller/user_post_controller.dart';
import '../../../db/model/post_model.dart';
import '../../../db/model/comments/comment.dart';
import '../../../service/services/get_comment.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late Future<List<Comment>> _futureComments;

  int commentCount = 0;

  @override
  void initState() {
    super.initState();
    _futureComments = fetchComments(widget.post.id);
    _futureComments.then((comments) {
      setState(() {
        commentCount = comments.length;
      });
    });
  }

  final AddCommentsController commentdi = Get.put(AddCommentsController());
  final PostsController controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.post.user.photo),
                            ),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post.user.fullName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    widget.post.createdAt.timeAgo(),
                                    style: const TextStyle(
                                      color: Color(0xffA3A3A3),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        15.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.post.text,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        15.heightBox,
                        PostActionsRow(
                          postidforlike: widget.post.id,
                          likecount: widget.post.likecount,
                          pressLike: () {},
                          pressComment: () {
                            commentdi.showCommentDialog(
                              post_id:'${widget.post.id}',

                            );
                          },
                          pressShare: () {
                            final String postContent = widget.post.text;
                            onSharePressed(postContent);
                          },
                          commentsCount: widget.post.commentsCount,
                        ),
                      ],
                    ),
                  ),
                ),
                20.heightBox,
                const Text(
                  'التعليقات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                10.heightBox,
                Expanded(
                  child: FutureBuilder<List<Comment>>(
                    future: _futureComments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final comments = snapshot.data!;
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              _futureComments = fetchComments(widget.post.id);
                            });
                          },
                          child: ListView.separated(
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        comment.userComments.photo),
                                  ),
                                  title: Text(
                                    comment.userComments.fullName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        comment.commentText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 10,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSharePressed(String message) {
    Share.share("$message\n تم النسخ من تطبيق كتكوتي 🐥");
  }
}
