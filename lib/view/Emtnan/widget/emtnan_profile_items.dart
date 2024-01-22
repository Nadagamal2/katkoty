import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/view/Emtnan/widget/likes_of_profile.dart';
import 'package:katkoty/view/Emtnan/widget/share_profile.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/list.dart';

class EmtnanProfileItems extends StatefulWidget {
  const EmtnanProfileItems({super.key});

  @override
  State<EmtnanProfileItems> createState() => _EmtnanProfileItemsState();
}

class _EmtnanProfileItemsState extends State<EmtnanProfileItems> {
  int _selectedIndex = 0;
  bool _toggleState = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      counter = 0;
                      setState(() {});
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: counter == 0
                              ? Colors.grey.shade300
                              : Colors.grey.shade300
                      ),
                      child: Center(
                        child: Text(
                          'الاعجابات',
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontSize: 13,
                            color: counter == 0
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      counter = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: counter == 1
                              ? Colors.grey.shade300
                              : Colors.grey.shade300),
                      child: Center(
                        child: Text(
                          'مشاركتي',
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontSize: 13,
                            color: counter == 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   mainAxisSize: MainAxisSize.max,
            //   children: List.generate(
            //     2,
            //     (index) => GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _toggleState = !_toggleState;
            //           _selectedIndex = _toggleState ? 1 : 0;
            //         });
            //       },
            //       child:
            //       // child: Center(
            //       //   child: FittedBox(
            //       //     child: Text(
            //       //       textProfile[index],
            //       //       style: TextStyle(
            //       //         fontWeight: FontWeight.w500,
            //       //         color: _selectedIndex == index
            //       //             ? Get.isDarkMode
            //       //                 ? const Color.fromARGB(255, 106, 106, 106)
            //       //                 : const Color.fromARGB(255, 106, 106, 106)
            //       //             : Get.isDarkMode
            //       //                 ? Colors.white
            //       //                 : Colors.black,
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ),
            //   ),
            // ),
            Divider(
              thickness: .5,
              height: 20,
              color: Colors.grey,
            ),
            counter == 0?LikeProfile():ShareProfile()
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //
            //       if (_selectedIndex == 0) ...[
            //         Padding(
            //           padding:const EdgeInsets.all(8.0),
            //           child:  ShareProfile(),
            //         ),
            //       ] else if (_selectedIndex == 1) ...[
            //         Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child:    LikeProfile()
            //
            //
            //         ),
            //       ]
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
