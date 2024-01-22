import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:katkoty/packages/alarm/screens/app_sounds_screen/app_sound_viewmodel.dart';
import 'package:katkoty/packages/alarm/services/alarm_api_service.dart';

class AppSoundsScreen extends StatefulWidget {
  const AppSoundsScreen({Key? key}) : super(key: key);

  @override
  State<AppSoundsScreen> createState() => _AppSoundsScreenState();
}

class _AppSoundsScreenState extends State<AppSoundsScreen>
    implements AppSoundsImpl {
  late AppSoundViewModel viewModel;

  @override
  void initState() {
    viewModel = AppSoundViewModel(this);
    super.initState();
    viewModel.getAppSound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اختر نغمة".tr),
      ),
      body: ListView.builder(
        itemCount: viewModel.sounds.length,
        itemBuilder: (BuildContext context, index) {
          var soundData = viewModel.sounds[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    File file = await DefaultCacheManager().getSingleFile(
                        AlarmApiService.BASE_SOUND_URL + soundData.url!);
                    soundData.cashedFile = file;
                    Navigator.pop(context, soundData);
                  },
                  child: Text(
                    soundData.name!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    viewModel.playSound(soundData);
                  },
                  icon: const Icon(Icons.play_arrow),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void notifyState() {
    setState(() {});
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
