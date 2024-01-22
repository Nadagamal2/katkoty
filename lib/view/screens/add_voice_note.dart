import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katkoty/controller/add_voice_note_controller.dart';

class AddVoiceNote extends GetWidget<AddVoiceNoteController> {
  const AddVoiceNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(),
          body: const Column(
            children: [],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.addNote();
            },
            child: controller.recording.value == false
                ? const Icon(Icons.mic)
                : const Icon(Icons.mic_off),
          ),
        ));
  }
}
