import 'package:get/get.dart';

import '../db/model/post_model.dart';
import '../service/services/user_post.dart';

class PostsController extends GetxController {
  final PostsService _postsService = PostsService();
  RxList posts = [].obs;
  bool like = false;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void tapLike() {
    like =  !like;
    update();
  }


  void fetchPosts() async {
    try {
      var posts = await PostsService.getPosts();
      this.posts = posts.obs;
      update();
    } catch (e) {}
  }
   Future<void> refreshPosts() async {
    try {
      posts.clear();
      final List<Post> refreshedPosts = await PostsService.getPosts();
      posts.addAll(refreshedPosts);
      update(); // Notify GetBuilder to update the UI
    } catch (error) {
      print('Error refreshing posts: $error');
    }
  }
}
