import 'package:get/get.dart';
import '../db/model/user_like_model.dart';
import '../service/services/user_like_services.dart';
import '../service/shared_preference/user_preference.dart';

class UserLikesController extends GetxController {
  final String apiUrl =
      'https://katkoty-app.com/admin/api/community/get_user_likes.php?user_id=';
  final UserLikesService apiService = UserLikesService(
      apiUrl:
          'https://katkoty-app.com/admin/api/community/get_user_likes.php?user_id=${UserPreferences.getUserid()}');
  final userLikes = <UserLike>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiService.fetchData();
      userLikes.assignAll(data);
      print(userLikes);
    } catch (e) {
      print('Error: $e');
    }
  }
}
