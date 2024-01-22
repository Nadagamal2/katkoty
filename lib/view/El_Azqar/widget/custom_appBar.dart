import 'package:flutter/material.dart';
import '../../../utils/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed; // Modified property to VoidCallback

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0.0,
      backgroundColor: AppbarColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: onPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xff4D4D4D),
        ),
      ),
    );
  }
}
