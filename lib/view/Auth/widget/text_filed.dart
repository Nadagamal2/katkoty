import 'package:flutter/material.dart';

Widget buildTextField({
  required String hintText,
  required IconData prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  String? Function(String?)? validator,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[200]!,
        ),
      ),
    ),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null ? suffixIcon : null,
      ),
      obscureText: obscureText,
      validator: validator,
    ),
  );
}
