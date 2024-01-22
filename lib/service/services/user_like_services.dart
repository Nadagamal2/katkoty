import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../db/model/user_like_model.dart';

class UserLikesService {
  final String apiUrl;

  UserLikesService({required this.apiUrl});

  Future<List<UserLike>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)["user_like"];
      return jsonData.map((item) => UserLike.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
