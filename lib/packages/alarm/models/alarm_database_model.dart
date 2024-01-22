import 'dart:convert';

import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/packages/alarm/models/alarm_model.dart';
import 'package:katkoty/db/models/database_model.dart';

class AlarmDatabaseModel implements DatabaseModel {
  int? id;
  AlarmModel? alarmData;

  AlarmDatabaseModel({this.alarmData, this.id});

  AlarmDatabaseModel.fromJson(Map<String, dynamic> json) {
    alarmData = AlarmModel.fromJson(jsonDecode(json['alarm_data']));
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alarm_data'] = jsonEncode(alarmData!.toJson());
    data['id'] = id;
    return data;
  }

  @override
  String? database() {
    return AppDatabase.DATABASE_NAME;
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String? table() {
    return AppDatabase.ALARMS;
  }

  @override
  Map<String, dynamic>? toMap() {
    return toJson();
  }
}
