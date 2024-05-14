import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/radio_controller.dart';
import 'package:islamic_app/models/radio_model.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:wave_blob/wave_blob.dart';

class QuranRadioView extends StatelessWidget {
  const QuranRadioView({super.key, required this.radioModel});
  final RadioModel radioModel;

  @override
  Widget build(BuildContext context) {
    // AudioController audioController = Get.find();
    RadioController radioController = Get.find();
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) async {
          if (didPop) {
            await radioController.pauseRadio();
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
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 4,
                    width: MediaQuery.sizeOf(context).width / 4,
                    child: WaveBlob(
                      amplitude:
                          radioController.radioIsPlaying.value ? 8000 : 4000,
                      blobCount: radioController.radioIsPlaying.value ? 5 : 2,
                      speed: radioController.radioIsPlaying.value ? 8 : 2,
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
                      child: InkWell(
                        onTap: () async {
                          if (radioController.radioIsPlaying.value ||
                              radioController.radioIsLoading.value) {
                            await radioController.pauseRadio();
                            return;
                          }
                          await radioController.playRadio(radioModel.link);
                          // AwesomeNotifications().createNotification(content: NotificationContent(id: id, channelKey: channelKey).
                          return;
                        },
                        child: Center(
                          child: radioController.radioIsLoading.value
                              ? const CircularProgressIndicator()
                              : AnimatedCrossFade(
                                  secondChild: const Icon(
                                    CupertinoIcons.play_arrow_solid,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  firstChild: const Icon(
                                    CupertinoIcons.pause_solid,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  crossFadeState:
                                      radioController.radioIsPlaying.value
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
                      radioController.radioIsPlaying.value ? 9000 : 81000,
                      radioController.radioIsPlaying.value ? 2000 : 4000,
                      radioController.radioIsPlaying.value ? 5000 : 25000,
                      radioController.radioIsPlaying.value ? 4000 : 16000,
                      radioController.radioIsPlaying.value ? 2000 : 4000,
                      radioController.radioIsPlaying.value ? 3000 : 9000,
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
                    isLoop: radioController.radioIsPlaying.value,
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
