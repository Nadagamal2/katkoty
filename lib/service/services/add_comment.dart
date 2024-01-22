import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
final userData2 = GetStorage();
class AddComments {
  static Future<void> addComment({

    required String postId,
    required String commentText,
  }) async {
    const url = 'https://katkoty-app.com/admin/api/community/add_comment.php';

    final response = await http.post(Uri.parse(url), body: {
      'server': 'AddComment',
      'user_id': userData2.read('id'),
      'post_id': postId,
      'comment_text': commentText,
    });
    if (response.statusCode == 200) {
      print('#######################################');


      print(response.body);

      print(postId);
      print(response.statusCode);

      print(commentText);

    }
    else {
      throw Exception('Failed to set like');
    }



  }
}