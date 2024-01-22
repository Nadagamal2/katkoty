import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/models/fadfada_model.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddNoteController extends GetxController {
  static AddNoteController get instance => Get.put(AddNoteController());

  AppDatabase appDatabase = AppDatabase();

  Rx<DateTime> todayDate = DateTime.now().obs;

  GlobalKey<FormState> addNoteKey = GlobalKey<FormState>();
  TextEditingController addNoteControl = TextEditingController();
 // TextEditingController EditNoteControl = TextEditingController();
  RxBool speechEnabled = false.obs;

  SpeechToText speechToText = SpeechToText();

  onSpeechResult(SpeechRecognitionResult result) {
    addNoteControl.text = result.recognizedWords;
    //EditNoteControl.text = result.recognizedWords;
    if (speechToText.isNotListening) {
      speechEnabled.value = false;
    }
  }

  void initSpeech() async {
    await speechToText.initialize();
  }

  speak() async {
    RxBool available = (await speechToText.initialize()).obs;
    if (available.value) {
      Fluttertoast.showToast(msg: 'تحدث الان'.tr);
      speechEnabled.value = true;
      speechToText.listen(
          onResult: onSpeechResult,
          listenMode: ListenMode.dictation,
          localeId: 'ar');
    } else {
      speechToText.hasPermission;
    }
  }

  stop() {
    speechEnabled.value = false;
    speechToText.stop();
  }

  talkBtn() {
    return speechEnabled.value == false
        ? IconButton(
            onPressed: () {
              speak();
              speechEnabled.value = true;
            },
            icon: const Icon(
              Icons.mic,
              size: 30,
              color: Colors.amber,
            ))
        : AvatarGlow(
            endRadius: 60.0,
            glowColor: Colors.amber,
            child: Material(
              // Replace this child with your own
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 30.0,
                child: IconButton(
                    onPressed: () {
                      stop();
                      speechEnabled.value = false;
                    },
                    icon: const Icon(
                      Icons.mic_off,
                      color: Colors.amber,
                    )),
              ),
            ),
          );
  }

  Future addNote() async {
    var note = FadfadaModel()..note = addNoteControl.text;
    await appDatabase.insert(note);
  }

  @override
  void onInit() {
    super.onInit();
    initSpeech();
  }
}
