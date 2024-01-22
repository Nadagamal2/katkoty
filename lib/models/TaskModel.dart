import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/db/models/database_model.dart';

class TaskModel implements DatabaseModel {
  String? note;
  String? task;
  int? id = -1;

  TaskModel({this.note, this.task, this.id});

  TaskModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    task = json['task'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['task'] = this.task;
    data['id'] = this.id;
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
    return AppDatabase.TASKS_TABLE;
  }

  @override
  Map<String, dynamic>? toMap() {
    return toJson();
  }
}
