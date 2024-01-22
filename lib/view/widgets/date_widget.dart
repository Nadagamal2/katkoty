import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDateWidget extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;

  const SelectDateWidget(
      this.yearController, this.monthController, this.dayController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('katkoty_birthdate'.tr),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: dayController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "day".tr,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: monthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "month".tr),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: yearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "year".tr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
