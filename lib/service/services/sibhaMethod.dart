import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../db/model/sibha_Model.dart';

Future<SibhaModel> fetchSibhaData() async {
  final response = await http
      .get(Uri.parse('https://katkoty-app.com/admin/api/get_sibha_all.php'));

  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return SibhaModel.fromJson(parsedJson);
  } else {
    throw Exception('Failed to fetch sibha data');
  }
}
