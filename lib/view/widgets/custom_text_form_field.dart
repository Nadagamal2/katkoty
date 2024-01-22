import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, required this.labelText, this.obscure = false, this.icon, required this.onChanged, required this.validator, this.hintText = "", this.controller, this.maxLines, this.maxLength}) : super(key: key);

  final String labelText;
  final String hintText;
  final int? maxLines;
  final int? maxLength;
  final Widget? icon;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool obscure;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        textAlign: TextAlign.right,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          suffixIcon: icon,
          labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: Colors.white
        ),
        obscureText: obscure,
      ),
    );
  }
}
