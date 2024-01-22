import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';

import '../../view/screens/home.dart';

class LikeResponse {
  final bool success;
  final String status;

  LikeResponse({
    required this.success,
    required this.status,
  });

  factory LikeResponse.fromJson(Map<String, dynamic> json) {
    return LikeResponse(
      success: json['success'] ?? false,
      status: json['status'] ?? '',
    );
  }
}

class PostLikeController extends GetxController {
  RxBool isLiked = false.obs;
   final RxInt postlikeCount = 0.obs;
  bool _isRequestInProgress = false;
  int previousLikeCount = 0;

  Future<LikeResponse> toggleLike() async {
    if (_isRequestInProgress) {
      return LikeResponse(success: false, status: 'Request in progress');
    }

    try {
      _isRequestInProgress = true;

      if (isLiked.value) {
      previousLikeCount = postlikeCount.value;
        postlikeCount.value--;
        isLiked.value = false;
        print(isLiked.value);
        return await _likeUnlikePost(like: false);

      } else {
     previousLikeCount = postlikeCount.value;
        postlikeCount.value++;
        isLiked.value = true;
        print(isLiked.value);
        return await _likeUnlikePost(like: true);
      }
    } finally {
      _isRequestInProgress = false;
    }
  }

  Future<LikeResponse> _likeUnlikePost({required bool like}) async {
    try {
      final response = await http.post(
        Uri.parse('https://katkoty-app.com/admin/api/community/set_like.php'),
        body: {'like': like.toString()},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final likeCountValue = int.tryParse(responseData['like_count'] ?? '');
        if (likeCountValue != null) {
          postlikeCount.value = likeCountValue >= 0 ? likeCountValue : 0;
          return LikeResponse(
              success: true,
              status: like ? 'Liked successfully.' : 'Unliked successfully.');
        } else {
          return LikeResponse(
              success: false, status: 'Failed to parse like_count.');
        }
      } else {
       postlikeCount.value = previousLikeCount;
        isLiked.value = !like;
        return LikeResponse(
            success: false,
            status:
                'Failed to ${like ? 'like' : 'unlike'} post. Server returned status code ${response.statusCode}');
      }
    } catch (e) {
     postlikeCount.value = previousLikeCount;
      isLiked.value = !like;
      print('Error ${like ? 'liking' : 'unliking'} post: $e');
      return LikeResponse(
          success: false,
          status: 'Error occurred while ${like ? 'liking' : 'unliking'} post.');
    }
  }













  final userData2 = GetStorage();
  Future<void> setLike(int postId, String likeCount) async {
    const String baseUrl =
        'https://katkoty-app.com/admin/api/community/set_like.php';

    try {
      final response = await http.post(Uri.parse(baseUrl), body: {
        'server': 'SetLike',
        'user_id': userData2.read('id'),
        'post_id': postId.toString(),
        'like': likeCount
      });
      if (response.statusCode == 200) {
        print('#######################################');
        toggleLike();


        print(response.body);
        print(userData2.read('id'));
        print(postId.toString());
    //    print(response.statusCode);
       // print(postlikeCount.value++);
      //  print(postlikeCount.value++);

        print(likeCount);

      }
    } catch (e) {
      print(e);
    }
  }
  void delete(String UserId,PostId)async{
    var request = http.MultipartRequest('POST', Uri.parse('https://katkoty-app.com/admin/api/community/add_post.php'));
    request.fields.addAll({
      'user_id': UserId,
      'server': 'DeletePost',
      'id': PostId,
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.offAll(Home());
    }
    else {
      print(response.reasonPhrase);
    }
  }

}
