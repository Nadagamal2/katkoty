import 'package:flutter/material.dart';
import '../../../../utils/color.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard(
      {super.key,
      required this.imagepath,
      required this.depname,
      required this.action});
  final String imagepath;
  final String depname;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: 150,
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xfffafafa)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imagepath),
              const SizedBox(
                height: 10,
              ),
              Text(
                depname,
                style: const TextStyle(
                    fontSize: 18,
                    color: AppbarColor,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
