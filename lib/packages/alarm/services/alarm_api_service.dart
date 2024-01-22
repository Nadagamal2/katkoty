import 'package:dio/dio.dart';
import 'package:katkoty/packages/alarm/models/resources.dart';
import 'package:katkoty/packages/alarm/models/status.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/models/sound_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AlarmApiService {
  static const String BASE_URL = "https://katkoty-app.com/admin/api/";
  static const String BASE_SOUND_URL = "https://katkoty-app.com/admin/sounds/";

  var dio = Dio();

  static final AlarmApiService _singleton = AlarmApiService._internal();

  factory AlarmApiService() {
    return _singleton;
  }

  AlarmApiService._internal();

  Future<AlarmApiService> initAPIs() async {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );
    var options = BaseOptions(
      baseUrl: BASE_URL,
    );
    dio.options = options;
    return _singleton;
  }

  Future<Resource<SoundsResponse>> getSounds() async {
    try {
      var response = await dio.get(
        'sounds.php',
      );
      var re = SoundsResponse.fromJson(response.data);
      return Resource(Status.SUCCESS, data: re);
    } catch (e) {
      print('all-categories erro  = $e');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }
}
