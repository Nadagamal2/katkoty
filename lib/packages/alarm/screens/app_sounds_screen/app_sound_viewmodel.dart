import 'package:just_audio/just_audio.dart';
import 'package:katkoty/packages/alarm/models/status.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/models/sound_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model_impl.dart';
import 'package:katkoty/packages/alarm/services/alarm_api_service.dart';

abstract class AppSoundsImpl extends BaseViewModelImpl {}

class AppSoundViewModel extends BaseViewModel {
  AppSoundsImpl impl;
  AlarmApiService apiService = AlarmApiService();

  List<SoundsModel> sounds = [];

  AppSoundViewModel(this.impl);

  void getAppSound() async {
    var response = await apiService.getSounds();
    if (response.status == Status.SUCCESS) {
      sounds.addAll(response.data!.sounds!);
    }

    notifyState();
  }

  AudioPlayer soundPlayer = AudioPlayer();
  void playSound(SoundsModel sound) {
    soundPlayer.setUrl('${AlarmApiService.BASE_SOUND_URL}${sound.url}');
    soundPlayer.play();
  }

  void notifyState() {
    impl.notifyState();
  }

  void dispose() {
    soundPlayer.dispose();
  }
}
