import 'dart:convert';

import '../../db/model/changeZqer.dart';
import 'package:http/http.dart' as http;

Future<SibhaResponseModel> fetchSibhaData() async {
  final response = await http
      .get(Uri.parse('https://katkoty-app.com/admin/api/get_sibha_one.php'));

  if (response.statusCode == 200) {
    return SibhaResponseModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}
