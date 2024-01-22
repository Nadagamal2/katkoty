import 'package:get/get.dart';
import 'package:record/record.dart';

class AddVoiceNoteController extends GetxController {
  final record = Record();
  RxBool recording = false.obs;

  addNote() async {
    bool isRecording = await record.isRecording();
    if (await record.hasPermission()) {
      if(isRecording == false){
        recording.value = true;
        await record.start(
          path: 'assets/rec/myFile.m4a',
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
          device: const InputDevice(label: 'test', id: '2'),
        );
      }
      else{
        await record.stop();
        recording.value = false;
      }
    }
  }
}
