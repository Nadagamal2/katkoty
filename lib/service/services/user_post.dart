import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../db/model/post_model.dart';

class PostsService {
  static Future<List<Post>> getPosts() async {
    var url = 'https://katkoty-app.com/admin/api/community/get_posts.php';
    var uri = Uri.parse(url);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var posts =
          List<Post>.from(json['posts'].map((post) => Post.fromJson(post)));

      return posts;
    } else {
      throw Exception('Failed to get posts');
    }
  }
}
