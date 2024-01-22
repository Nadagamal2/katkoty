import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:katkoty/main.dart';
import 'package:katkoty/view/screens/home.dart';
import 'package:katkoty/view/screens/notes.dart';

import '../../view/screens/Done_Screen.dart';
final userData2 = GetStorage();
class FadfdaApiService {
  static const String baseUrl =
      'https://katkoty-app.com/admin/api/add_fadfada.php';

  Future<void> sendFormData({

    required String text,
  }) async {
    final Uri uri = Uri.parse(baseUrl);

    final Map<String, String> body = {
      'server': 'Add',
      'user_id': '${userData2.read('id')}',
      'text': text,
    };

    try {
      final response = await http.post(uri, body: body);
     var data2 = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        // Request was successful
        print('Request Successful: ${response.body}');


  Get.offAll(()=>Home());


     //   final data = await Get.to(const Notes());
      } else {
        // Request failed
        print('Request Failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> EditFormData({
    required String userId,
    required String text,
    required String id,
  }) async {
    final Uri uri = Uri.parse(baseUrl);

    final Map<String, String> body = {
      'server': 'Edit',
      'user_id': userId,
      'text': text,
      'post_id': id,
    };

    try {
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        // Request was successful
        print('Request Successful: ${response.body}');
        Get.offAll(()=>Home());
      } else {
        // Request failed
        print('Request Failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> DeleteFormData({
    required String userId,
    required String id,
  }) async {
    final Uri uri = Uri.parse(baseUrl);

    final Map<String, String> body = {
      'server': 'Delete',
      'user_id': userId,
      'post_id': id,
    };

    try {
      final response = await http.post(uri, body: body);

      if (response.statusCode == 200) {
        // Request was successful
        print('Request Successful: ${response.body}');
        Get.back();
      } else {
        // Request failed
        print('Request Failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static const getbaseUrl = 'https://katkoty-app.com/admin/api/';

  // Future<List<GetFadfdaModel>> getPosts(int userId) async {
  //   print('try');
  //   final response = await http.get(
  //     Uri.parse('https://katkoty-app.com/admin/api/get_fadfada.php?user_id=18'),
  //   );
  //   print('https://katkoty-app.com/admin/api/get_fadfada.php?user_id=18');
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     print('getit');
  //     final List<dynamic> jsonList = json.decode(response.body);
  //     return jsonList.map((json) => GetFadfdaModel.fromJson(json)).toList();
  //   } else {
  //     print('failed------------------');
  //     throw Exception('Failed to load posts');
  //   }
  // }
}

class GetFadfdaModel {
  final int id;
  final String text;
  final DateTime createdAt;

  GetFadfdaModel({required this.id, required this.text, required this.createdAt});
  
  // Add a factory method to parse JSON
  factory GetFadfdaModel.fromJson(Map<String, dynamic> json) {
    return GetFadfdaModel(
      id: json['id'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

