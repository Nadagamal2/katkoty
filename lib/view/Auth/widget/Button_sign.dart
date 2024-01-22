import 'package:flutter/material.dart';

import '../signUp.dart';

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback? onClick;

  const ButtonWidget({Key? key, required this.btnText, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColors, orangeLightColors],
            end: Alignment.centerLeft,
            begin: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
