import 'package:flutter/material.dart';

Widget textInput({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  required Color color,
  bool obscureText = false,
  FormFieldValidator<String>? validator,
  Widget? suffixIcon,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15))),
              hintText: hint,
              filled: true,
              fillColor: color,
              prefixIcon: Icon(icon),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ),
        Positioned(
          top: -18,
          left: 10,
          child: Text(
            validator != null ? validator(controller.text) ?? '' : '',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
