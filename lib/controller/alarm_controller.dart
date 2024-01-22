import 'dart:async';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AlarmController extends GetxController {

  static AlarmController instance = Get.find();

  RxList alarms = [].obs;

  Stream<List> alarmsStream(){


    return alarms.stream;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    alarms.bindStream(alarmsStream());
    initAutoStart();
  }
  Future<void> initAutoStart() async {
    try {

      //check auto-start availability.
      var test = await (isAutoStartAvailable as FutureOr<bool>);
      print(test);
      print("tttttttttttttttttttttttttttttttttttttttt");
      //if available then navigate to auto-start setting page.
      if (test) await getAutoStartPermission();
    } on PlatformException catch (e) {
      print(e);

    }

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }

}