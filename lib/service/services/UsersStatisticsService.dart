import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:katkoty/db/model/UserStaticsModel.dart';

class UsersStatisticsService {
  static const String apiUrl =
      'https://katkoty-app.com/admin/api/community/get_users_statistics.php'; 

  Future<List<UserStaticsModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users_statistics'];
      return data.map((json) => UserStaticsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
}
}
}