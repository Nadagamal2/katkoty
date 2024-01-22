import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_repeate.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/models/sound_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model_impl.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/packages/alarm/utils/alarms_manager.dart';

abstract class EditAlarmImpl extends BaseViewModelImpl {}

class EditAlarmViewModel extends BaseViewModel {
  EditAlarmImpl impl;
  AlarmDatabaseModel? alarmDatabaseModel;

  AppDatabase appDatabase = AppDatabase();

  DateTime dateTime = DateTime.now();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  var isNewAlarm = true;
  var isHasVibration = false;
  var isHasSnooze = false;

  DateTime customSelectedDate = DateTime.now();
  String repeatType = RepeatType.once.name;
  List<String> repeatedDaysList = [
    AlarmDay.saturday.name,
    AlarmDay.sunday.name,
    AlarmDay.monday.name,
    AlarmDay.tuesday.name,
    AlarmDay.wednesday.name,
    AlarmDay.thursday.name,
    AlarmDay.friday.name,
  ];

  Set<String> selectedDays = <String>{};

  EditAlarmViewModel(this.impl);

  void setSnooze(bool isSnooze) {
    isHasSnooze = isSnooze;
    notifyState();
  }

  void setVibration(bool vibration) {
    isHasVibration = vibration;
    notifyState();
  }

  void setSelectedDay(bool selected, String value) {
    if (!selected) {
      selectedDays.remove(value);
    } else {
      selectedDays.add(value);
    }
    if (selectedDays.length == 7) {
      repeatType = RepeatType.allDays.name;
    } else {
      repeatType = RepeatType.specificDays.name;
    }
    notifyState();
  }

  void setCustomSelectedDate(DateTime? selectedDate) {
    if (selectedDate == null) return;
    repeatType = RepeatType.custom.name;
    selectedDays.clear();
    customSelectedDate = selectedDate;
    notifyState();
  }

  String soundResource = AlarmSoundResource.cashPath.name;
  var pickedFiePath = "";
  var pickedFieName = "";
  File? selectedAudioFile;

  void pickSoundFileFromDevice() async {
    soundResource = AlarmSoundResource.cashPath.name;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      selectedAudioFile = File(result.files.single.path!);
      pickedFiePath = result.files.single.path!;
      pickedFieName = pickedFileName();
      print('path  = ${result.files.single.path!}');
    }
    notifyState();
  }

  void pickSoundFileFromApp(SoundsModel? result) async {
    if (result == null) return;
    soundResource = AlarmSoundResource.cashPath.name;
    selectedAudioFile = result.cashedFile;
    pickedFiePath = result.cashedFile!.path;
    pickedFieName = result.name ?? "";
    notifyState();
  }

  Future<DateTime?> save() async {
    AlarmDatabaseModel newAlarmDatabaseModel = AlarmDatabaseModel();
    AlarmModel newAlarm = AlarmModel();

    int remainMillSec = (dateTime.millisecondsSinceEpoch -
        DateTime.now().millisecondsSinceEpoch);

    print('new_alarm_remain_mill_sec= $remainMillSec');
    if (remainMillSec > 1000) {
      newAlarm.millisecondsSinceEpoch = dateTime.millisecondsSinceEpoch;
    } else {
      newAlarm.millisecondsSinceEpoch =
          dateTime.add(const Duration(days: 1)).millisecondsSinceEpoch;
    }
    newAlarm.title = titleTextController.value.text;
    newAlarm.description = descriptionTextController.value.text;
    newAlarm.snooze = isHasSnooze;
    newAlarm.vibration = isHasVibration;
    newAlarm.repeatType = repeatType;
    newAlarm.finished = false;
    newAlarm.soundPath = pickedFiePath;
    newAlarm.soundName = pickedFileName();
    newAlarm.soundSource = soundResource;
    newAlarm.specificDays = selectedDays.toList();
    newAlarm.customDateMillisecondsSinceEpoch =
        customSelectedDate.millisecondsSinceEpoch;

    newAlarmDatabaseModel.alarmData = newAlarm;
    var alarmId = await appDatabase.insert(newAlarmDatabaseModel);

    AlarmModel insertedAlarm = (await refreshAlarms())
        .where((element) => element.id == alarmId)
        .toList()
        .first
        .alarmData!;

    return getNextAlarmDateTime(insertedAlarm);
  }

  String pickedFileName() => pickedFiePath.split("/").last;

  void notifyState() {
    impl.notifyState();
  }
}
