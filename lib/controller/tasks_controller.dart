//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/models/TaskModel.dart';

class TasksController extends GetxController {
  static TasksController instance = Get.find();
  AppDatabase appDatabase = AppDatabase();

  RxList tasks = [].obs;

  getTasks() async {
    appDatabase.getAllTasks().then((value) {
      tasks.clear();
      tasks.addAll(value);
    });
  }

  onTaskDoneDialog() async {
    return Get.defaultDialog(
        title: 'task_done'.tr,
        textConfirm: 'شكرا'.tr,
        confirmTextColor: Colors.black,
        cancelTextColor: Colors.black,
        radius: 20,
        content: Column(
          children: [
            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/giphy.gif')),
            Center(
              child: Text('task_done_msg'.tr),
            ),
          ],
        ));
  }

  onTaskDone(TaskModel task) async {
    await appDatabase.delete(task);
    await onTaskDoneDialog();
  }

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

  final zaghrotaPlayer = AudioPlayer();
  void playZaghrootaRingtone() async {
    zaghrotaPlayer.stop();
    await zaghrotaPlayer
        .setAudioSource(AudioSource.asset('assets/sounds/z.mp3'));
    zaghrotaPlayer.play();
  }

  @override
  void onClose() {
    zaghrotaPlayer.stop();
    zaghrotaPlayer.dispose();
    super.onClose();
  }
}
