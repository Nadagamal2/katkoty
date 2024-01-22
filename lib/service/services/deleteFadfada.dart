import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:katkoty/db/model/deleteFadfada.dart';

class DeleteFadfadaService extends GetxService {
  final String _endpoint = 'https://katkoty-app.com/admin/api/add_fadfada.php';

  Future<DeleteFadFdaa> deleteItem(
      {required String userId, required String itemId}) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      body: {
        'server': 'Delete',
        'user_id': userId,
        'id': itemId,
      },
    );

    if (response.statusCode == 200) {
      return DeleteFadFdaa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
