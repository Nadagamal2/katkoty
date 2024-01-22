import 'package:flutter/material.dart';
import '../../../utils/color.dart';

class EmtnanScreen extends StatelessWidget {
  const EmtnanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppbarColor,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
          title: const Text('امتنان',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              )),
              
        ),
      )),
    );
  }
}
