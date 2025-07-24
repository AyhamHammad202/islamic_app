import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/ayat/widgets/readers.dart';
import 'package:quran_library/quran.dart';

import 'audio_botton.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.firstAyaInPage,
  });

  final AyahModel firstAyaInPage;

  @override
  Widget build(BuildContext context) {
    final settingsService = Get.find<SettingsService>();
    final audioController = Get.find<AudioController>();

    return GetX<AudioController>(
      builder: (_) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Readers(settingsService: settingsService),
            _buildAyaInfo(context, audioController),
            _buildProgressBar(context, audioController),
            _buildControls(audioController),
          ],
        ),
      ),
    );
  }

  Widget _buildAyaInfo(BuildContext context, AudioController controller) {
    final sura = controller.currentSura.arabicName;
    final number = controller.currentAya.ayahNumber;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        '$sura:$number',
        style: TextThemes.ayaInfoTextStyle(context),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, AudioController controller) {
    return SizedBox(
      width: 0.7.sw,
      child: ProgressBar(
        progress: controller.currentDuration.value,
        total: controller.duration.value,
        timeLabelLocation: TimeLabelLocation.below,
        timeLabelTextStyle: const TextStyle(color: Colors.white),
        onSeek: controller.audioPlayer.seek,
      ),
    );
  }

  Widget _buildControls(AudioController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AudioButton(
          icon: Icons.skip_next_rounded,
          onTap: () async {
            if (controller.ayaUniqeId.value >= 6236) return;
            await controller.peauseAyaFile();
            controller.ayaUniqeId.value++;
            await controller.playAyah(controller.currentAya);
          },
        ),
        AudioButton(
          icon: controller.isPlaying.value
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded,
          onTap: () async {
            if (controller.isPlaying.value || controller.isLoading.value) {
              await controller.peauseAyaFile();
            } else {
              await controller.playAyah(controller.currentAya);
            }
          },
        ),
        AudioButton(
          icon: Icons.skip_previous_rounded,
          onTap: () async {
            if (controller.ayaUniqeId.value <= 1) return;
            await controller.peauseAyaFile();
            controller.ayaUniqeId.value--;
            await controller.playAyah(controller.currentAya);
          },
        ),
      ],
    );
  }
}
