import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/radio_controller.dart';
import 'package:islamic_app/models/radio_model.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:lottie/lottie.dart';

class QuranRadioView extends StatelessWidget {
  const QuranRadioView({super.key, required this.radioModel});
  final RadioModel radioModel;

  @override
  Widget build(BuildContext context) {
    RadioController radioController = Get.find();
    return BackgroundImage(
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            radioController.stopRadio();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(Get.locale == const Locale('ar')
                ? radioModel.arabicName
                : radioModel.englishName),
          ),
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
                    height: MediaQuery.sizeOf(context).height / 6,
                    width: MediaQuery.sizeOf(context).width / 6,
                    child: InkWell(
                      onTap: () async {
                        if (radioController.radioIsPlaying.value ||
                            radioController.radioIsLoading.value) {
                          await radioController.pauseRadio();
                          return;
                        }
                        await radioController.playRadio(radioModel);
                        // AwesomeNotifications().createNotification(content: NotificationContent(id: id, channelKey: channelKey).
                        return;
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: Center(
                            child: radioController.radioIsLoading.value
                                ? LottieBuilder.asset(
                                    "assets/lottie/loading.json")
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
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
