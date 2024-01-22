import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import 'package:katkoty/utils/color.dart';
import 'package:katkoty/utils/strings.dart';

import '../../controller/user_post_controller.dart';
import '../../service/services/new_post.dart';
import '../AskYouerSelf/widget/buttons_dialog.dart';
import 'EmtnanFull.dart';

class EmtnanNewPost extends StatefulWidget {
  const EmtnanNewPost({Key? key}) : super(key: key);

  @override
  State<EmtnanNewPost> createState() => _EmtnanNewPostState();
}

class _EmtnanNewPostState extends State<EmtnanNewPost> {
  final TextEditingController postController = TextEditingController();
  bool isTextFieldEmpty = true;
  final PostsController postsController = Get.find();

  @override
  void initState() {
    super.initState();
    postController.addListener(updateTextFieldStatus);
  }

  void updateTextFieldStatus() {
    setState(() {
      isTextFieldEmpty = postController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  Future<void> _showPostSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          //   title: const Center(child: Text("نجاح")),
          content: const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              acceptPost,
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Center(child: ButtonDialog(
              onPressed: () {
              Navigator.of(context).pop();
                Get.to(() => const EmtnanFull());
              },
            )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.to(() => const EmtnanFull()),
          ),
          title: const Text('أشطر كتكوت'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Card(
              elevation: 0.8,
              shadowColor: AppbarColor,
              child: Container(
                height: Get.height / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: postController,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  minLines: 30,
                  maxLines: 70,
                  decoration: const InputDecoration(
                    hintText:
                        'بقدر الإمتنان تأتي السعادة، حابب \n تشاركنا بشئ ممتن ليه في يومك يا كتكوتي 💛',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              width: 250,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: postController,
                builder: (context, value, _) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTextFieldEmpty
                          ? const Color.fromARGB(255, 244, 223, 154)
                          : const Color(0xfff6c116),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      _showPostSuccessDialog();

                      await AddPost.addPost(
                        userId: UserPreferences.getUserid(),
                        text: postController.value.text,
                      );

                      if (kDebugMode) {
                        print(UserPreferences.getUserid());
                        print(postController.value.text);
                      }

                      await postsController.refreshPosts();
                    //  Navigator.pop(context);
                    },
                    child: Text(
                      "نشر",
                      style: TextStyle(
                        color: isTextFieldEmpty ? Colors.grey : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
