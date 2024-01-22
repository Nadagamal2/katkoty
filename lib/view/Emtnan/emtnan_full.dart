/* import 'package:flutter/material.dart';

import 'package:katkoty/view/Emtnan/emtnan_post.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/list.dart';
import '../El_Azqar/widget/custom_appBar.dart';

class EmtnanScreen extends StatefulWidget {
  const EmtnanScreen({
    super.key,
  });

  @override
  State<EmtnanScreen> createState() => _EmtnanScreenState();
}

class _EmtnanScreenState extends State<EmtnanScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'امتنان',
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            Padding(
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
                    child: Container(
                      height: 46,
                      width: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _selectedIndex == index
                              ? const Color(0xffF6C116)
                              : Colors.black,
                          width: 1,
                        ),
                        color: _selectedIndex == index
                            ? const Color(0xffF6C116)
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          emtnan[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_selectedIndex != -1) ...[
              if (_selectedIndex == 0) ...[
                const Padding(
                    padding: EdgeInsets.all(8.0), child: EmtnanPost()),
              ],
              if (_selectedIndex == 1) ...[
                const Padding(
                    padding: EdgeInsets.all(8.0), child: EmtnanPost()),
              ],
              if (_selectedIndex == 2) ...[
                const Padding(
                    padding: EdgeInsets.all(8.0), child: EmtnanPost()),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
 */