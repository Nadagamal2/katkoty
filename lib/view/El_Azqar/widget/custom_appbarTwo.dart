import 'package:flutter/material.dart';
import '../../../utils/color.dart';

class CustomAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed;
  final TabController? tabController; // Added property for TabController

  const CustomAppBarTwo({
    Key? key,
    required this.title,
    required this.onPressed,
    this.tabController,
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
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right),
            onPressed: onPressed,
          ),
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          height: 3 / 2,
          fontWeight: FontWeight.bold,
          color: Color(0xff4D4D4D),
        ),
      ),
      bottom: tabController != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal,
                ),
                child: TabBar(
                  controller: tabController!,
                  tabs: const [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                    Tab(text: 'Tab 4'),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
