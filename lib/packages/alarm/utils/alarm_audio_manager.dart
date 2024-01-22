import 'package:just_audio/just_audio.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

AudioPlayer alarmAudioPlayer = AudioPlayer();

playAudio(AlarmDatabaseModel alarmDatabaseModel) async {
  String soundPath = "";

  var alarmData = alarmDatabaseModel.alarmData!;
  if (alarmDatabaseModel.alarmData!.soundPath == null ||
      alarmDatabaseModel.alarmData!.soundPath!.isEmpty) {
    var defaultRingtone = await SharedPreferences.getInstance();
    soundPath = await defaultRingtone.getString("defaultRingtone") ?? "";
  } else {
    soundPath = alarmDatabaseModel.alarmData!.soundPath!;
  }

  print('soundPath = ${soundPath}');

  final playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
      AudioSource.file(soundPath),
    ],
  );

  await alarmAudioPlayer.setAudioSource(playlist);
  await alarmAudioPlayer.setLoopMode(LoopMode.off);
  await alarmAudioPlayer.play();
  if (alarmData.vibration!) {
    Vibration.vibrate(
        duration: alarmAudioPlayer.duration!.inMilliseconds,
        pattern: [alarmAudioPlayer.duration!.inMilliseconds]);
  }
}
