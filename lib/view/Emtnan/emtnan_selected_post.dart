import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../db/model/post_model.dart';
import 'widget/social_buttons.dart';

class EmtnanPostPreview extends StatelessWidget {
  final Post post;

  const EmtnanPostPreview({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.user.fullName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
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
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(post.user.photo),
                        ),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.user.fullName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                post.createdAt.toString(),
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
                        post.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(),
                    15.heightBox,
                    PostActionsRow(
                      postidforlike: post.id,
                      likecount: post.likecount,
                      pressLike: () {},
                      pressComment: () {},
                      pressShare: () {}, commentsCount: 0,
                     
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
