// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';

import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/settings_service.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.firstAyaInPage,
  });
  final AyaOfSurahModel firstAyaInPage;

  @override
  Widget build(BuildContext context) {
    SettingsService settingsService = Get.find();
    AudioController audioController = Get.find();
    QuranController quranController = Get.find();
    return GetX<AudioController>(builder: (c) {
      return Container(
        color: Colors.red,
        height: 100.h,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PopupMenuButton(
              onSelected: (value) {
                settingsService.currentReaderIndex.value = value;
                settingsService.setReaderIndex(value);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(Constant
                      .readers[settingsService.currentReaderIndex.value]),
                  const Icon(Icons.arrow_drop_up_outlined),
                ],
              ),
              itemBuilder: (context) {
                return List.generate(
                  Constant.readers.length,
                  (index) => PopupMenuItem(
                    value: index,
                    child: Text(
                      Constant.readers[index],
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                AudioButton(
                  icon: Icons.skip_next_rounded,
                  onTap: () {
                    audioController.ayaUniqeId.value++;
                    audioController.playNext(
                      quranController.allAyas[audioController.ayaUniqeId.value],
                    );
                  },
                ),
                AudioButton(
                  icon: !audioController.isPlaying.value
                      ? Icons.play_arrow
                      : Icons.pause,
                  onTap: () async {
                    await audioController.playAyah(quranController
                        .allAyas[audioController.ayaUniqeId.value - 1]);
                  },
                ),
                AudioButton(
                  icon: Icons.skip_previous_rounded,
                  onTap: () {
                    // audioController.ayaUniqeId.value - 3;
                    audioController.playBack();
                  },
                ),
                Text(
                  audioController.currentDuration.value.inSeconds.toString(),
                ),
                Slider(
                  value: audioController.currentDuration.value.inSeconds
                      .toDouble(),
                  onChanged: (value) {
                    audioController.audioPlayer
                        .seek(Duration(seconds: value.toInt()));
                  },
                  max: audioController.duration.value.inSeconds.toDouble(),
                ),
                Text(
                  audioController.duration.value.inSeconds.toString(),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class AudioButton extends StatelessWidget {
  const AudioButton({
    super.key,
    this.onTap,
    required this.icon,
  });
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // AudioController audioController = Get.find();
    // QuranController quranController = Get.find();
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon),
    );
  }
}
