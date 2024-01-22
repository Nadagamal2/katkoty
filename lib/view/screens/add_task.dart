import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/add_task_controller.dart';
import '../widgets/custom_text_form_field.dart';

class AddTask extends GetWidget<AddTaskController> {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Form(
            key: controller.taskFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'مهمة جديدة'.tr,
                  icon: const Icon(Icons.edit),
                  onChanged: (value) {
                    controller.taskName.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty ? 'إكتب المهمة الاول'.tr : null,
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomTextFormField(
                  labelText: 'إضافة ملاحظة'.tr,
                  icon: const Icon(Icons.add),
                  onChanged: (value) {
                    controller.taskNote.value = value!.trim();
                  },
                  validator: (String? value) =>
                      value!.isEmpty ? 'اضف ملاحظة'.tr : null,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.taskFormKey.currentState?.validate() == true) {
                await controller.addNewTask(
                    controller.taskName.value, controller.taskNote.value);
                // controller.taskName.value = '';
                Get.back();
              }
            },
            child: Text('إضافة المهمة'.tr),
          )
        ],
      ),
    );
  }
}
