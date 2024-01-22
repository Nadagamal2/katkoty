import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import '../service/services/add_comment.dart';
import '../service/shared_preference/user_preference.dart';

class AddCommentsController extends GetxController {
  void showCommentDialog({required String post_id, }) {
    final TextEditingController commentTextController = TextEditingController();
    final RegExp nonSpaceRegExp = RegExp(r'[^\s]');

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 214, 214, 214),
                  ),
                ),
                child: TextField(
                  minLines: 10,
                  maxLines: 30,
                  controller: commentTextController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'قم بكتابه تعليقك هنا'.tr,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final commentText = commentTextController.text;
                  if (nonSpaceRegExp.hasMatch(commentText)) {
                    await AddComments.addComment(

                      postId: post_id,
                      commentText: commentText,
                    );

                    Get.back();
                  } else {
                    Get.back();
                  }
                },
                child: const Text('إرسـال'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> setLike(int postId, int likeCount) async {
//   const String baseUrl =
//       'https://katkoty-app.com/admin/api/community/set_like.php';
//
//   try {
//     final response = await http.post(baseUrl as Uri, body: {
//       'server': 'SetLike',
//       'user_id': UserPreferences.getUserid(),
//       'post_id': postId.toString(),
//       'likecount': likeCount.toString()
//     });
//     if (response.statusCode != 200) {
//       throw Exception('Failed to set like');
//     }
//   } catch (e) {
//     throw Exception('Failed to set like: $e');
//   }
// }
