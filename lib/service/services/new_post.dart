import 'package:http/http.dart' as http;

class AddPost {
  static Future<void> addPost({
    required String userId,
    required String text,
  }) async {
    const url = 'https://katkoty-app.com/admin/api/community/add_post.php';

    final response = await http.post(Uri.parse(url), body: {
      'server': 'AddPost',
      'user_id': userId,
      'text': text,
    });
    print('see(response.statusCode );');
    print(response.statusCode);
    print(response.body);
    print(userId);
    print(text);
  }
}
