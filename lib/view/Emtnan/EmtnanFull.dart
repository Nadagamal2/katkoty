import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/color.dart';
import '../../utils/list.dart';
import '../El_Azqar/widget/custom_appBar.dart';
import '../screens/home.dart';
import 'emtnan_new_post.dart';
import 'emtnan_post.dart';
import 'emtnan_profile.dart';
import 'emtnan_users.dart';

class EmtnanFull extends StatefulWidget {
  const EmtnanFull({super.key});

  @override
  State<EmtnanFull> createState() => _EmtnanFullState();
}

class _EmtnanFullState extends State<EmtnanFull> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
         floatingActionButton: _getFAB(),
      appBar: CustomAppBar(
        onPressed: () {
          Get.to(() =>   Home());
        },
        title: 'امتنان'.tr,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Card(
                      elevation: _selectedIndex == index ? 5 : 0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == index
                            ? const Color(0xffF6C116)
                            : Colors.transparent,
                        child: Container(
                          height: 46,
                          width: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _selectedIndex == index
                                  ? const Color(0xffF6C116)
                                  : Get.isDarkMode
                                      ? const Color(0xffF6C116)
                                      : const Color.fromARGB(67, 0, 0, 0),
                              width: 1,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                textEmtnan[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: _selectedIndex == index
                                      ? Get.isDarkMode
                                          ? Colors.white
                                          : Colors.white
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : const Color(0xff4D4D4D),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.heightBox,
                  if (_selectedIndex == 0) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EmtnanPost(),
                    ),
                  ] else if (_selectedIndex == 1) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EmtnanUsers(),
                    ),
                  ] else if (_selectedIndex == 2) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EmtnanProfile(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _getFAB() {
    if (_selectedIndex!=0) {
      return Container();
    } else {
      return FloatingActionButton(
        onPressed: () {
          Get.to(() => const EmtnanNewPost());
        },
        backgroundColor: AppbarColor,
        child: const Icon(Icons.add),
      );
    }
  }
}
