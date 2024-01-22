import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:katkoty/db/model/editiFadfada.dart';

class EditService extends GetxService {
  final String _endpoint = 'https://katkoty-app.com/admin/api/add_fadfada.php';

  Future<EditFadFadaResponse> editItem({
    required String userId,
    required String itemId,
    required String text,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      body: {
        'server': 'Edit',
        'user_id': userId,
        'id': itemId,
        'text': text,
      },
    );

    if (response.statusCode == 200) {
      return EditFadFadaResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit item');
    }
  }
}
