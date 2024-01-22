import 'package:flutter/material.dart';

import '../../../utils/color.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double testSize;
  final Color? color;
  final double? borderRadius;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
    required this.testSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppbarColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: testSize,
            ),
          ),
        ),
      ),
    );
  }
}
