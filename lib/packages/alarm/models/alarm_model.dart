enum AlarmSoundResource { cashPath, assets }

class AlarmModel {
  int? snoozedAlarmId;
  String? title;
  String? description;
  int? millisecondsSinceEpoch;
  int? customDateMillisecondsSinceEpoch;
  String? repeatType;
  String? soundPath;
  String? soundName;
  String? soundSource;
  List<String>? specificDays;
  bool? finished;
  bool? snooze;
  bool? vibration = false;
  DateTime time = DateTime.now();
  DateTime date = DateTime.now();

  AlarmModel();

  AlarmModel.fromJson(Map<String, dynamic> json) {
    snoozedAlarmId = json['snoozedAlarmId'];
    title = json['title'];
    description = json['description'];
    soundPath = json['soundPath'];
    soundName = json['soundName'];
    soundSource = json['soundSource'];
    millisecondsSinceEpoch = json['millisecondsSinceEpoch'];
    customDateMillisecondsSinceEpoch = json['customDateMillisecondsSinceEpoch'];
    repeatType = json['repeat_type'];
    if (json['specific_days'] != null) {
      specificDays = json['specific_days'].cast<String>();
    }
    finished = json['finished'];
    snooze = json['snooze'];

    time = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch!);

    if (customDateMillisecondsSinceEpoch != null) {
      date = DateTime.fromMillisecondsSinceEpoch(
          customDateMillisecondsSinceEpoch!);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['snoozedAlarmId'] = snoozedAlarmId;
    data['description'] = description;
    data['soundPath'] = soundPath;
    data['soundName'] = soundName;
    data['soundSource'] = soundSource;
    data['millisecondsSinceEpoch'] = millisecondsSinceEpoch;
    data['customDateMillisecondsSinceEpoch'] = customDateMillisecondsSinceEpoch;
    data['repeat_type'] = repeatType;
    data['specific_days'] = specificDays;
    data['finished'] = finished;
    data['snooze'] = snooze;
    return data;
  }
}
