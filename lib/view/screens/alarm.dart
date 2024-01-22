import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/controller/alarm_controller.dart';
import 'package:katkoty/utils/strings.dart';

import '../El_Azqar/widget/custom_appBar.dart';
import '../El_Azqar/widget/custom_dialog.dart';

class Alarm extends GetWidget<AlarmController> {
  const Alarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();

    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogealarm') ?? false;
    /* if (!hasShownDialoge) {
     
      box.write('hasShownDialogealarm', true);
    } */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myDialogController.showDefaultDialog(
          contant: const Text(
        alarmWelcom,
        textAlign: TextAlign.center,
      ));
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: 'التنبيهات'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      body: Platform.isIOS
          ? Center(
              child: Text('رسالة التنبهات'.tr),
            )
          : Obx(() => ListView.builder(
                itemCount: controller.alarms.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 15, left: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              InkWell(
                                child: Card(
                                  color: Colors.amber[600],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    child: ListTile(
                                      title: Text(
                                        controller.alarms[index]['alarmName'],
                                        textAlign: TextAlign.right,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${'الوقت'.tr} : '),
                                              // Text('${DateFormat().add_jm().format(DateTime.fromMillisecondsSinceEpoch(((controller.alarms[index]['alarmTime'] as Timestamp ).seconds) * 1000))}'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${'النغمه'.tr} : '),
                                              Expanded(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      enabled: false,
                                                      border: InputBorder.none,
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                      hintText:
                                                          '${controller.alarms[index]['alarmSoundName']}'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${'التكرار'.tr} : '),
                                              Text(controller.alarms[index]
                                                      ['repeat']
                                                  .toString()
                                                  .replaceAll('[', '')
                                                  .replaceAll(']', '')
                                                  .tr),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${'id'.tr} : '),
                                              Text(
                                                  '${controller.alarms[index]['id']}'),
                                            ],
                                          ),
                                          controller.alarms[index]['nap'] ==
                                                  false
                                              ? const Text('')
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('${'غفوة'.tr} : '),
                                                    const Icon(Icons.check),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.initAutoStart();
          Get.toNamed('add_alarm');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
