import 'package:get/get.dart';

DateTime clearSecondsFromDateTime(DateTime alarmDateTime) {
  DateTime clearAlarmTime = DateTime(
    alarmDateTime.year,
    alarmDateTime.month,
    alarmDateTime.day,
    alarmDateTime.hour,
    alarmDateTime.minute,
    0,
    0,
    0,
  );
  return clearAlarmTime;
}

String formatDatetime(DateTime dateTime) {
  int delayMill = clearSecondsFromDateTime(dateTime).millisecondsSinceEpoch -
      DateTime.now().millisecondsSinceEpoch;

  var remainTimeHours =
      int.parse("${delayMill / (60000 * 60)}".split(".")[0].toString());
  var remainTimeMinutes = double.parse(
          "${delayMill / (60000 * 60)}".replaceAll("$remainTimeHours.", "0.")) *
      60;

  return " $remainTimeHours ${'ساعة'.tr} ${'و'.tr}${" ${remainTimeMinutes.toInt()} ${'دقيقة'.tr} "
     'و'.tr} ${dateTime.second} ${'ثانية'.tr} ";
}
