import 'package:flutter/material.dart';


class CustomNoteTextFormField extends StatelessWidget {
  const CustomNoteTextFormField({Key? key, this.obscure = false, this.icon, required this.validator, this.hintText = "", this.controller, this.maxLines, this.maxLength}) : super(key: key);

  final String hintText;
  final int? maxLines;
  final int? maxLength;
  final Widget? icon;
  final String? Function(String?)? validator;
  final bool obscure;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        obscureText: obscure,
      ),
    );
  }
}
