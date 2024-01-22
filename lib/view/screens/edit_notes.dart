import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/controller/add_note_controller.dart';
import '../../service/services/fadfda_service.dart';
import '../../service/shared_preference/user_preference.dart';
import '../El_Azqar/widget/custom_appBar.dart';
import '../El_Azqar/widget/custom_utton.dart';
import '../widgets/custom_note_textForm.dart';

class EditNote extends GetWidget<AddNoteController> {
  String id;
  EditNote({Key? key,required this.id}) : super(key: key);
  final userData2 = GetStorage();
  @override
  Widget build(BuildContext context) {
    final AddNoteController EditNoteControl = Get.put(AddNoteController());
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'ركن الكتكوت الدافئ'.tr,
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Text('${controller.todayDate.value.year}-${controller.todayDate.value.month}-${controller.todayDate.value.day}  ${controller.todayDate.value.hour}:${controller.todayDate.value.minute}'),

            Form(
              key: controller.addNoteKey,
              child: CustomNoteTextFormField(
                controller: AddNoteController.instance.addNoteControl,


                 maxLines: 20,
                maxLength: 5000,
                validator: (String? value) =>
                value!.isEmpty ? 'اكتب حاجه الاول'.tr : null,
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           controller.addNoteControl.clear();
            //         },
            //         child: const Icon(
            //           CupertinoIcons.trash_fill,
            //           size: 25,
            //           color: Colors.red,
            //         ),
            //       ),
            //       Obx(() => controller.talkBtn()),
            //     ],
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                  width: 175,
                  height: 40,


                  borderRadius: 21,
                  onPressed: () async {
                    await FadfdaApiService().EditFormData(
                        userId: userData2.read('id') ,
                        text: EditNoteControl.addNoteControl.text, id:  id);

                  },
                  testSize: 18,
                  color: Colors.white,
                  text: 'حفظ',
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
