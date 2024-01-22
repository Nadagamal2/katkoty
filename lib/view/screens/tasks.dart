import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/tasks_controller.dart';
import 'package:katkoty/models/TaskModel.dart';
import 'package:katkoty/view/widgets/bnner_ad.dart';

class Tasks extends GetWidget<TasksController> {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اشطر كتكوت'.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
                  itemCount: controller.tasks.length,
                  itemBuilder: (BuildContext context, index) {
                    var taskModel = (controller.tasks[index] as TaskModel);
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 15, right: 15, left: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.amber[600],
                        child: ListTile(
                          title: Text(
                            '${'المهمه : '.tr}${taskModel.task}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${'الملاحظه : '.tr}${taskModel.note}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: IconButton(
                              onPressed: () async {
                                controller.playZaghrootaRingtone();
                                controller.onTaskDone(taskModel);
                                controller.getTasks();
                              },
                              icon: const Icon(Icons.done)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 2,
                      thickness: 2,
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed('add_task');
          controller.getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
