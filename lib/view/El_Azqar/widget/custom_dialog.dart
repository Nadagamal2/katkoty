import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AskYouerSelf/widget/buttons_dialog.dart';

class MyDialogController extends GetxController {
  void showDefaultDialog({
    String? title,
    required Widget contant,
    Widget? icon,
  }) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                )
              : null,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: contant,
          ),
          actions: const [
            Center(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: ButtonDialog())),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
