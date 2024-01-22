import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonDialog extends StatelessWidget {
  final VoidCallback? onPressed; 

  const ButtonDialog({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
        width: 119,
        height: 43,
        padding: const EdgeInsets.only(top: 3),
        decoration: ShapeDecoration(
          color: const Color(0xFFF6C116),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const SizedBox(
          width: 69,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 11,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'حسناً',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
