import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/ayat/widgets/readers.dart';

import 'audio_botton.dart';

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
    // QuranController quranController = Get.find();
    return GetX<AudioController>(builder: (c) {
      return Container(
        // height: 100.h,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap(4.h),
            Readers(settingsService: settingsService),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${audioController.currentSura.nameOfSurah}:${audioController.currentAya.numberOfAyaInSurah}",
                  style: TextThemes.ayaInfoTextStyle(context),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: ProgressBar(
                progress: audioController.currentDuration.value,
                total: audioController.duration.value,
                timeLabelLocation: TimeLabelLocation.below,
                timeLabelTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                onSeek: (duration) {
                  audioController.audioPlayer.seek(duration);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AudioButton(
                  icon: Icons.skip_next_rounded,
                  onTap: () async {
                    if (audioController.ayaUniqeId.value == 6236) {
                      return;
                    }
                    await audioController.peauseAyaFile();
                    audioController.ayaUniqeId.value++;
                    await audioController.playAyah(audioController.currentAya);
                  },
                ),
                AudioButton(
                  icon: !audioController.isPlaying.value
                      ? Icons.play_circle_fill_rounded
                      : Icons.pause_circle_filled_rounded,
                  onTap: () async {
                    if (audioController.isPlaying.value ||
                        audioController.isLoading.value) {
                      await audioController.peauseAyaFile();
                      return;
                    }
                    await audioController.playAyah(audioController.currentAya);
                  },
                ),
                AudioButton(
                  icon: Icons.skip_previous_rounded,
                  onTap: () async {
                    // audioController.ayaUniqeId.value - 3;
                    if (audioController.ayaUniqeId.value > 1) {
                      await audioController.peauseAyaFile();
                      audioController.ayaUniqeId.value--;
                      await audioController
                          .playAyah(audioController.currentAya);
                      return;
                    }
                    return;
                  },
                ),
              ],
            ),
            Gap(4.h),
          ],
        ),
      );
    });
  }
}
