import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:katkoty/service/shared_preference/user_preference.dart';
import '../service/services/fadfda_service.dart';
import '../view/screens/notes.dart';

class UserFadfdaController extends GetxController {
  final RxList<GetFadfdaModel> fadfda = <GetFadfdaModel>[].obs;
  final userData2 = GetStorage();
  // Future fetchData() async {
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           'https://katkoty-app.com/admin/api/get_fadfada.php?user_id=${userData2.read('id')}'));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //
  //     Map<String, dynamic> jsonResponse =
  //         json.decode(await response.stream.bytesToString());
  //     print(jsonResponse);
  //
  //     List  posts = jsonResponse['posts'];
  //
  //
  //         posts.map((post) => GetFadfdaModel.fromJson(post)).toList();
  // Get.to(Notes());
  //
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
  //
  // @override
  // void onInit() async {
  //   print(fadfda.toJson());
  //
  //   await fetchData();
  //   print(fadfda.toJson());
  //   super.onInit();
  // }
}
