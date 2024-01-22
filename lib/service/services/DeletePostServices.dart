import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:katkoty/db/model/DeletePostModel.dart';
import 'package:katkoty/view/screens/home.dart';

class DeletePostService {
  Future<DeletePostResponse> deletePost(String server, String userId, String postId) async {
    const url = 'https://katkoty-app.com/admin/api/community/add_post.php';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'server': server,
      'user_id': userId,
      'id': postId,
    });

    final response = await http.delete(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Get.offAll(Home());
      return DeletePostResponse(
        message: responseData['message'],
        success: responseData['success'],
      );

    } else {
      throw Exception('Failed to delete post.');
    }
  }
}
