import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/packages/alarm/screens/alarms_screen/alarms_list_viewmodel.dart';
import 'package:katkoty/packages/alarm/screens/alarms_screen/widgets/alarm_item_widget.dart';
import 'package:katkoty/packages/alarm/utils/alarm_date_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/strings.dart';
import '../../../../view/El_Azqar/widget/custom_appBar.dart';
import '../../../../view/El_Azqar/widget/custom_dialog.dart';

class AlarmsListScreen extends StatefulWidget {
  const AlarmsListScreen({Key? key}) : super(key: key);

  @override
  State<AlarmsListScreen> createState() => _AlarmsListScreenState();
}

class _AlarmsListScreenState extends State<AlarmsListScreen>
    implements AlarmsImpl {
  late AlarmsListViewModel viewModel;

  @override
  void initState() {
    viewModel = AlarmsListViewModel(this);
    viewModel.getAlarms();
    super.initState();
    iniDefaultRingTone();
  }

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    final MyDialogController myDialogController = Get.put(MyDialogController());
    bool hasShownDialoge = box.read<bool>('hasShownDialogealarm') ?? false;
    if (!hasShownDialoge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        myDialogController.showDefaultDialog(
            contant: const Text(
          alarmWelcom,
          textAlign: TextAlign.center,
        ));
      });
      box.write('hasShownDialogealarm', true);
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'التنبيهات'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      body: ListView.builder(
        itemCount: viewModel.alarmsList.length,
        itemBuilder: (BuildContext context, index) {
          return AlarmItemWidget(viewModel, viewModel.alarmsList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var dateTime = await Get.toNamed('add_alarm');
          print("walid fekry");
          print(dateTime);
          if (dateTime != null) {
            viewModel.getAlarms();
            showRemainTime(dateTime);
          }
        },
      ),
    );
  }

  showRemainTime(DateTime time) {
    return Get.defaultDialog(
        title: 'كتكوتي'.tr,
        textConfirm: 'حسناً'.tr,
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        radius: 20,
        onConfirm: () {
          Get.back();
        },
        content: SizedBox(
          height: 100,
          width: 200,
          child: Center(
            child: Text(
              '${'remain_time_msg'.tr}\n${formatDatetime(time)}',
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  @override
  void notifyState() {
    setState(() {});
  }

  void iniDefaultRingTone() async {
    var defaultRingtone = await SharedPreferences.getInstance();
    if (defaultRingtone.getString("defaultRingtone") == null) {
      File file = await DefaultCacheManager()
          .getSingleFile("https://katkoty-app.com/admin/sounds/1.mp3");
      await defaultRingtone.setString("defaultRingtone", file.path);
    }
  }
}
