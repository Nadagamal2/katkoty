import 'package:get/get.dart';
import '../models/fadfda_model.dart';
import '../service/services/fadfda_service.dart';


class FadfdaController extends GetxController {
  final FadfdaApiService apiService;

  FadfdaController({required this.apiService});

  Future<void> sendData(FadfdaModel data) async {
    try {
     // await apiService.sendFormData( userId: data.userId.toString(),text:data.text );
   //   await apiService.EditFormData( userId: data.userId.toString(),text:data.text, id: '${data.postId}' );
      // Handle success
    } catch (e) {
      print(e);
      // Handle errors
    }
  }
}
