import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../db/model/comments/comment.dart';

Future<List<Comment>> fetchComments(int postId) async {
  final response = await http.get(Uri.parse('https://katkoty-app.com/admin/api/community/get_comments.php?post_id=$postId'));
  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body)['posts_comments'] as List<dynamic>;
    return jsonList.map((json) => Comment.fromJson(json)).toList();
    print ('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  } else {
    throw Exception('Failed to fetch comments');
  }
}