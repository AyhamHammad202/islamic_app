import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:wave_blob/wave_blob.dart';

class QuranRadioView extends StatelessWidget {
  const QuranRadioView({super.key});

  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.find();
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) async {
          if (didPop) {
            await audioController.pauseRadio();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text(S.current.radio),
          // ),
          body: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                SvgPicturesMethods.radioBackgroundIcon(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
                InkWell(
                  onTap: () async {
                    if (audioController.radioIsPlaying.value ||
                        audioController.radioIsLoading.value) {
                      await audioController.pauseRadio();
                      return;
                    }
                    await audioController.playRadio();
                    // AwesomeNotifications().createNotification(content: NotificationContent(id: id, channelKey: channelKey).
                    return;
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height / 4,
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: WaveBlob(
                        amplitude:
                            audioController.radioIsPlaying.value ? 8000 : 4000,
                        blobCount: audioController.radioIsPlaying.value ? 5 : 2,
                        speed: audioController.radioIsPlaying.value ? 8 : 2,
                        colors: [
                          Theme.of(context).colorScheme.onSecondary,
                          Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.9),
                          Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.6),
                          Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.4),
                          Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.2),
                          Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(0.1),
                        ],
                        // circleColors: const [],
                        // scale: 2,
                        autoScale: true,
                        child: Center(
                          child: audioController.radioIsLoading.value
                              ? const CircularProgressIndicator()
                              : AnimatedCrossFade(
                                  secondChild: const Icon(
                                    CupertinoIcons.play_arrow_solid,
                                    size: 50,
                                  ),
                                  firstChild: const Icon(
                                    CupertinoIcons.pause_solid,
                                    size: 50,
                                  ),
                                  crossFadeState:
                                      audioController.radioIsPlaying.value
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                  duration: Durations.long1,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: WaveWidget(
                    config: CustomConfig(durations: [
                      audioController.radioIsPlaying.value ? 9000 : 81000,
                      audioController.radioIsPlaying.value ? 2000 : 4000,
                      audioController.radioIsPlaying.value ? 5000 : 25000,
                      audioController.radioIsPlaying.value ? 4000 : 16000,
                      audioController.radioIsPlaying.value ? 2000 : 4000,
                      audioController.radioIsPlaying.value ? 3000 : 9000,
                    ], heightPercentages: [
                      -1,
                      -0.8,
                      -0.6,
                      -0.4,
                      -0.3,
                      -0.1,
                    ], colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.9),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.6),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.4),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.2),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.1),
                      // Colors.red,
                    ]),
                    size: Size(MediaQuery.of(context).size.width, 20),
                    // waveAmplitude: 20,
                    // wavePhase: 200,
                    // waveFrequency: 2,
                    isLoop: !audioController.radioIsPlaying.value,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
