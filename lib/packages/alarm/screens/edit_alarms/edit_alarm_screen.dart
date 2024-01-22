import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_repeate.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/app_sounds_screen.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/models/sound_model.dart';
import 'package:katkoty/packages/alarm/screens/edit_alarms/edit_alarm_viewmodel.dart';
import 'package:katkoty/utils/color.dart';

import '../../../../view/El_Azqar/widget/custom_appBar.dart';
import '../../utils/alarm_date_utils.dart';

class EditAlarmScreen extends StatefulWidget {
  final AlarmDatabaseModel? alarmDatabaseModel;

  const EditAlarmScreen(this.alarmDatabaseModel, {Key? key}) : super(key: key);

  @override
  State<EditAlarmScreen> createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends State<EditAlarmScreen>
    implements EditAlarmImpl {
  late EditAlarmViewModel viewModel;

  @override
  void initState() {
    viewModel = EditAlarmViewModel(this);
    viewModel.alarmDatabaseModel = widget.alarmDatabaseModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ضبط المنبه'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        use24hFormat: false,
                        onDateTimeChanged: (dateTime) {
                          viewModel.dateTime = dateTime;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'اسم المنبه'.tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Expanded(
                          child: TextField(
                            controller: viewModel.titleTextController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: 'اضف عنوان'.tr),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الوصف'.tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Expanded(
                          child: TextField(
                            controller: viewModel.descriptionTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: '    اضف وصف'.tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'التكرار'.tr,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                DateTime? selectedDate =
                                    await selectDateDialog(context);
                                viewModel.setCustomSelectedDate(selectedDate);
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                            if (viewModel.repeatType == RepeatType.custom.name)
                              Text(
                                DateFormat.yMMMd()
                                    .format(viewModel.customSelectedDate),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Wrap(
                          spacing: 5.0,
                          children: List<Widget>.generate(
                            viewModel.repeatedDaysList.length,
                            (int index) {
                              String value = viewModel.repeatedDaysList[index];
                              return ChoiceChip(
                                label: Text(value.tr),
                                selected:
                                    viewModel.selectedDays.contains(value),
                                onSelected: (bool selected) {
                                  viewModel.setSelectedDay(selected, value);
                                },
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الاهتزاز'.tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                            activeColor: AppbarColor,
                            trackColor: CupertinoColors.inactiveGray,
                            thumbColor: CupertinoColors.white,
                            value: viewModel.isHasVibration,
                            onChanged: (val) {
                              viewModel.setVibration(val);
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'غفوة'.tr,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                            activeColor: AppbarColor,
                            trackColor: CupertinoColors.inactiveGray,
                            thumbColor: CupertinoColors.white,
                            value: viewModel.isHasSnooze,
                            onChanged: (val) {
                              viewModel.setSnooze(val);
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            showChooseSoundDialog(viewModel);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                'اختر نغمة'.tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Get.isDarkMode
                                        ? AppbarColor
                                        : Colors.black),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Text(
                            viewModel.pickedFieName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(38)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 12)),
                onPressed: () async {
                  if (viewModel.titleTextController.value.text == "" ||
                      viewModel.descriptionTextController.value.text == "") {
                    Fluttertoast.showToast(msg: 'برجاء ادخال عنوان ووصف اولا');
                  } else {
                    DateTime? alarmData = await viewModel.save();
                    Navigator.pop(context, alarmData);                  }
                },
                child: Text(
                  'حفظ'.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void notifyState() {
    setState(() {});
  }

  Future<DateTime?> selectDateDialog(context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
  }

  void showChooseSoundDialog(EditAlarmViewModel viewModel) {
    showModalBottomSheet<File>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اختر المصدر'.tr,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10)),
                    onPressed: () {
                      viewModel.pickSoundFileFromDevice();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اختر من الجهاز'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10)),
                    onPressed: () async {
                      var soundData = await Navigator.push(context,
                          MaterialPageRoute<SoundsModel>(
                        builder: (BuildContext context) {
                          return const AppSoundsScreen();
                        },
                      ));
                      viewModel.pickSoundFileFromApp(soundData);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اختر من التطبيق'.tr,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
