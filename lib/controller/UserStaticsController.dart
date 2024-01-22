import 'package:get/get.dart';

import '../db/model/UserStaticsModel.dart';
import '../service/services/UsersStatisticsService.dart';

class UserStaticsController extends GetxController {
  final UsersStatisticsService _userService = UsersStatisticsService();
  var users = <UserStaticsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final data = await _userService.fetchUsers();
      users.assignAll(data);
    } catch (e) {
      print('Error fetching data: $e');
}
}
}