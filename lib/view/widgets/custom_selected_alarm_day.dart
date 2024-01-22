import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelectedAlarmDay extends StatelessWidget {
  CustomSelectedAlarmDay({Key? key, required this.text, required this.list})
      : super(key: key);

  final RxBool selected = false.obs;
  final String text;
  final List list;
  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          child: SizedBox(
            height: 50,
            width: 100,
            child: Card(
              color: list.contains(text) ? Colors.amber : Colors.white,
              shape: list.contains(text)
                  ? RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10))
                  : RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.amber, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(text)),
            ),
          ),
          onTap: () {
            if (list.contains(text) == false) {
              if (selected.value == false && text == 'مرة واحدة'.tr) {
                list.clear();
                list.add(text);
                Get.back();
              } else if (selected.value == false && text == 'يومياً'.tr) {
                list.clear();
                list.add(text);
                Get.back();
              } else {
                if (selected.value == false ||
                    list.contains('يومياً') ||
                    list.contains('مرة واحدة')) {
                  list.remove('مرة واحدة');
                  list.remove('يومياً');
                  selected.value = true;
                  list.addIf(list.contains(text) == false, text);
                } else {
                  selected.value = false;
                  list.remove(text);
                }
              }
            } else {
              list.remove(text);
            }
          },
        ));
  }
}


// if(selected.value == false && text == 'مرة واحدة'.tr){
//           list.clear();
//           list.add(text);
//           Get.back();
//         }else if(selected.value == false && text == 'يومياً'.tr){
//           list.clear();
//           list.add(text);
//           Get.back();
//         }
//         else{
//           if(selected.value == false){
//             selected.value = true;
//             list.addIf(list.contains(text) == false, text);
//           }else{
//             selected.value = false;
//             list.remove(text);
//           }
//         }