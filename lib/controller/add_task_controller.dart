import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/models/TaskModel.dart';

class AddTaskController extends GetxController {
  AppDatabase appDatabase = AppDatabase();
  GlobalKey<FormState> taskFormKey = GlobalKey<FormState>();

  RxString taskName = ''.obs;
  RxString taskNote = ''.obs;
  RxList tasksList = [].obs;

  addNewTask(task, note) async {
    var newTask = TaskModel()
      ..note = note
      ..task = task;
    await appDatabase.insert(newTask);
  }
}
