import 'package:get/get.dart';
import 'package:katkoty/controller/add_note_controller.dart';
import 'package:katkoty/controller/add_voice_note_controller.dart';
import 'package:katkoty/controller/alarm_controller.dart';
import 'package:katkoty/controller/note_controller.dart';
import 'package:katkoty/controller/quotes_controller.dart';
import 'package:katkoty/service/api_service.dart';
import '../controller/add_task_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/home_controller.dart';
import '../controller/tasks_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => QuotesController(), fenix: true);
    Get.lazyPut(() => TasksController(), fenix: true);
    Get.lazyPut(() => AddTaskController(), fenix: true);
    Get.lazyPut(() => AddNoteController(), fenix: true);
    Get.lazyPut(() => NoteController(), fenix: true);
    Get.lazyPut(() => AlarmController(), fenix: true);
    Get.lazyPut(() => AddVoiceNoteController(), fenix: true);
  }
}
