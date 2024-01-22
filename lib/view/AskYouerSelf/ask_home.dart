import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/view/AskYouerSelf/widget/Stats.dart';
import 'package:katkoty/view/AskYouerSelf/widget/Treasures.dart';
import 'package:katkoty/view/AskYouerSelf/widget/quran.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/list.dart';
import '../../utils/strings.dart';
import '../El_Azqar/widget/custom_appBar.dart';
import '../El_Azqar/widget/custom_dialog.dart';
import 'widget/elazkarScreen.dart';
import 'widget/prayeAndFinsh.dart';

class AskYourSelf extends StatefulWidget {
  const AskYourSelf({
    super.key,
  });

  @override
  State<AskYourSelf> createState() => _AskYourSelfState();
}

class _AskYourSelfState extends State<AskYourSelf> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogeask') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            contant: const Text(
          prayDialog,
          textAlign: TextAlign.center,
        ));
      });
      box.write('hasShownDialogeask', true);
    }
    return Scaffold(
  //    backgroundColor: Get.isDarkMode ? Colors.black87 : Colors.white,
      appBar: CustomAppBar(
        title: 'حاسب نفسك',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      5,
                      (index) => Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Card(
                              elevation: _selectedIndex == index ? 5 : 0,
                              child: Material(
                                //  elevation: _selectedIndex == index ? 2 : 0,
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
                                              : const Color.fromARGB(
                                                  67, 0, 0, 0),
                                      width: 1,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        texts[index],
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
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(width: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  20.heightBox,
                  if (_selectedIndex != -1) ...[
                    if (_selectedIndex == 0) ...[
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: PrayAndFinshPray()),
                    ],
                    if (_selectedIndex == 1) ...[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: QuranWidget()),
                    ],
                    if (_selectedIndex == 2) ...[
                      const Padding(
                          padding: EdgeInsets.all(8.0), child: ElazkarScreen()),
                    ],
                    if (_selectedIndex == 3) ...[
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TreasuresWidget()),
                    ],
                    if (_selectedIndex == 4) ...[
                      const Padding(
                          padding: EdgeInsets.all(8.0), child: StatsScreen()),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
