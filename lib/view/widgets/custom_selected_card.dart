import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelectedCard extends StatelessWidget {
  CustomSelectedCard({Key? key, required this.text, this.onTap})
      : super(key: key);

  final RxBool selected = false.obs;
  final String text;
  final void Function(String?)? onTap;
  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          child: SizedBox(
            height: 50,
            width: 100,
            child: Card(
              color: selected.value ? Colors.amber : Colors.white,
              shape: selected.value
                  ? RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(10))
                  : RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.amber, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(text)),
            ),
          ),
          onTap: () {
            onTap;
            selected.value == false
                ? selected.value = true
                : selected.value = false;
          },
        ));
  }
}
