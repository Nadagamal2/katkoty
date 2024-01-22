import 'package:alarm/alarm.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_repeate.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/packages/alarm/utils/alarm_date_utils.dart';
import 'package:katkoty/packages/alarm/utils/notification_manager.dart';

Future<List<AlarmDatabaseModel>> refreshAlarms() async {
  AppDatabase appDatabase = await AppDatabase().initDb();
  List<AlarmDatabaseModel> alarmsList = await appDatabase.getAllAlarms();
  var newAlarms = alarmsList.where((element) => !element.alarmData!.finished!);

  for (var element in newAlarms) {
    setAlarm(element);
  }
  return alarmsList;
}

void setAlarm(AlarmDatabaseModel alarmDbModel) async {
  AlarmModel alarm = alarmDbModel.alarmData!;
  DateTime? nextAlarmDateTime = getNextAlarmDateTime(alarm);
  if (nextAlarmDateTime != null) {
    scheduleAlarm(nextAlarmDateTime, alarmDbModel);
  } else {
    setAlarmFinished(alarmDbModel);
  }
}

DateTime? getNextAlarmDateTime(AlarmModel alarm) {
  DateTime currentTime = DateTime.now();
  DateTime alarmTime = alarm.time;

  DateTime nextAlarmDateTime = DateTime.now();

  if (alarm.repeatType == RepeatType.once.name) {
    if ((alarmTime.millisecondsSinceEpoch - currentTime.millisecondsSinceEpoch) > 1000) {
      nextAlarmDateTime = alarmTime;
    } else {
      return null;
    }
  } else if (alarm.repeatType == RepeatType.allDays.name) {
    if ((alarmTime.millisecondsSinceEpoch - currentTime.millisecondsSinceEpoch) < 0) {
      alarmTime.add(const Duration(days: 1));
    }
    nextAlarmDateTime = alarmTime;
  } else if (alarm.repeatType == RepeatType.custom.name) {
    var customDateTime =
        DateTime(alarm.date.year, alarm.date.month, alarm.date.day, alarmTime.hour, alarmTime.minute, 0, 0, 0);
    if ((alarmTime.millisecondsSinceEpoch - currentTime.millisecondsSinceEpoch) > 1000) {
      nextAlarmDateTime = customDateTime;
    } else {
      return null;
    }
  } else if (alarm.repeatType == RepeatType.specificDays.name) {
    nextAlarmDateTime = getNextDayDateTime(alarm);
  }
  return nextAlarmDateTime;
}

DateTime getNextDayDateTime(AlarmModel alarm) {
  DateTime alarmTime = alarm.time;
  List<int> daysNumbers = alarm.specificDays!.map((e) => e.dayNumber).toList();

  var nextDayNumber = -1;
  DateTime selectedDate = DateTime.now();
  while (nextDayNumber == -1) {
    if (daysNumbers.contains(selectedDate.weekday)) {
      if ((alarmTime.millisecondsSinceEpoch - selectedDate.millisecondsSinceEpoch) > 1000) {
        nextDayNumber = selectedDate.weekday;
      } else {
        selectedDate.add(const Duration(days: 1));
      }
    } else {
      selectedDate.add(const Duration(days: 1));
    }
  }

  var selectedDateTime =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day, alarmTime.hour, alarmTime.minute, 0, 0, 0);

  return selectedDateTime;
}

Future setAlarmFinished(AlarmDatabaseModel alarmDbModel) async {
  AlarmModel alarm = alarmDbModel.alarmData!;
  alarm.finished = true;
  alarmDbModel.alarmData = alarm;

  AppDatabase appDatabase = await AppDatabase().initDb();
  return await appDatabase.update(alarmDbModel);
}

void scheduleAlarm(DateTime alarmDateTime, AlarmDatabaseModel alarmDatabaseModel) async {
  DateTime clearAlarmTime = clearSecondsFromDateTime(alarmDateTime);
  int alarmDateTimeMillSec = clearAlarmTime.millisecondsSinceEpoch;
  int delayMill = alarmDateTimeMillSec - DateTime.now().millisecondsSinceEpoch;
  print("new alarm  = ${DateTime.fromMillisecondsSinceEpoch(clearAlarmTime.millisecondsSinceEpoch)}");
  print("new alarm delay time  = $delayMill");
  // await AndroidAlarmManager.oneShot(
  //   Duration(seconds: delayMill ~/ 1000),
  //   alarmDatabaseModel.id!,
  //   callback,
  //   exact: true,
  //   alarmClock: true,
  //   allowWhileIdle: true,
  //   wakeup: true,
  //   rescheduleOnReboot: true,
  //   params: alarmDatabaseModel.toJson(),
  // );
  final alarmSettings = AlarmSettings(
    id: alarmDatabaseModel.id!,
    dateTime: DateTime.now().add(const Duration(minutes: 5)),
    assetAudioPath: alarmDatabaseModel.alarmData?.soundPath ?? '',
    loopAudio: true,
    vibrate: true,
    fadeDuration: 3.0,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );
  await Alarm.set(alarmSettings: alarmSettings);
}

@pragma('vm:entry-point')
Future<void> callback(int id, Map<String, dynamic> alarmData) async {
  AwesomeNotifications().cancelAll();
  await setAlarmFinished(AlarmDatabaseModel.fromJson(alarmData));
  fireAlarmNotification(alarmData);
  refreshAlarms();
}

fireFakeAlarm() {
  AndroidAlarmManager.oneShot(
    const Duration(seconds: 5),
    9999999,
    () {
      print('fake alarm started');
    },
    exact: true,
    alarmClock: true,
    allowWhileIdle: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );
  AndroidAlarmManager.periodic(
    const Duration(minutes: 15),
    88888,
    () {
      print('fake alarm started');
    },
    exact: true,
    allowWhileIdle: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );
}
