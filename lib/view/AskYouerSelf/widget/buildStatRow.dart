import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

Widget buildStatRow(String title, String percentage) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 11),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
   //   color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey.withOpacity(0.3),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:  TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
