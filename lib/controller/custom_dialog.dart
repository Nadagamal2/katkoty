import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/utils/color.dart';

class CustomtDialogController extends GetxController {
  void showCustomtDialog({
     required String title,
    required Widget contant,
    Widget? icon,
  }) {
    Get.defaultDialog(
      title: title,
      custom: const Align(
        alignment: Alignment.topRight,
        child: Icon(CupertinoIcons.heart_fill , color: Colors.redAccent,),
      ),
      textConfirm: "حسناً",
      confirmTextColor: const Color(0xfff5f5f5),
      buttonColor: AppbarColor,
      barrierDismissible: false,
      onConfirm: () => Get.back(),
      radius: 20,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon != null) icon,
          contant,
        ],
      ),
    );
  }
}
