import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:katkoty/models/ArticlesModelresponse.dart';
import 'package:katkoty/models/GiftImageModel.dart';
import 'package:katkoty/models/QoutesModelresponse.dart';
import 'package:katkoty/models/ShokModelresponse.dart';
import 'package:katkoty/models/WansModelresponse.dart';
import 'package:katkoty/models/resources.dart';
import 'package:katkoty/models/status.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static ApiService instance = Get.find();

  static const String BASE_URL = "https://katkoty-app.com/admin/api/";
  static const String BASE_IMAGES_URL = "https://katkoty-app.com/admin/images/";

  var dio = Dio();

  ApiService() {
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
  }

  Future<Resource<GiftImageModel>> getGidtImages() async {
    try {
      var response = await dio.get(
        'wheel.php',
      );
      var videoResponse =
          GiftImageModel.fromJson(jsonDecode(response.data.toString()));
      return Resource(Status.SUCCESS, data: videoResponse);
    } catch (e) {
      print("getGidtImages = ${e}");
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<QoutesModelresponse>> getTodayQuotes() async {
    try {
      var response = await dio.get(
        'quotes.php',
      );
      var videoResponse =
          QoutesModelresponse.fromJson(jsonDecode(response.data.toString()));
      return Resource(Status.SUCCESS, data: videoResponse);
    } catch (e) {
      print("getGidtImages = ${e}");
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<ShokModelresponse>> getShokApi() async {
    try {
      var response = await dio.get(
        'shok.php',
      );
      var videoResponse =
      ShokModelresponse.fromJson(jsonDecode(response.data.toString()));
      return Resource(Status.SUCCESS, data: videoResponse);
    } catch (e) {
      print("getGidtImages = ${e}");
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<WansModelresponse>> getWansApi() async {
    try {
      var response = await dio.get(
        'wans.php',
      );
      var videoResponse =
      WansModelresponse.fromJson(jsonDecode(response.data.toString()));
      return Resource(Status.SUCCESS, data: videoResponse);
    } catch (e) {
      print("getGidtImages = ${e}");
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<ArticlesModelResponse>> getDrAhmedArticles() async {
    try {
      var response = await dio.get(
        'article.php',
      );
      var videoResponse =
          ArticlesModelResponse.fromJson(jsonDecode(response.data.toString()));
      return Resource(Status.SUCCESS, data: videoResponse);
    } catch (e) {
      print("getGidtImages = ${e}");
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }
}
