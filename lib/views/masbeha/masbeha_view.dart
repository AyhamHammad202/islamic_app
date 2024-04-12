import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/tasbeha_model.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:wave_blob/wave_blob.dart';

class MasbehaView extends StatelessWidget {
  const MasbehaView({super.key, required this.tasbehaModel});
  final TasbehaModel tasbehaModel;

  @override
  Widget build(BuildContext context) {
    final MesbahaController mesbahaController = Get.find();
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) {
          mesbahaController.times.value = 0;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Obx(() {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tasbehaModel.tasbeha,
                    style: TextThemes.tasbehTextStyle,
                  ),
                  Gap(32.h),
                  Text(
                    tasbehaModel.info,
                    style: TextThemes.tasbehDescTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${tasbehaModel.times} ${S.current.time}",
                    style: TextThemes.tasbehDescTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Gap(64.h),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 5,
                    width: MediaQuery.sizeOf(context).width / 5,
                    child: WaveBlob(
                      amplitude: 8000,
                      blobCount: 5,
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
                      circleColors: const [
                        Colors.black,
                        Colors.white,
                      ],
                      scale: 2,
                      autoScale: false,
                      child: Center(
                        child: InkWell(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            mesbahaController.incretment(tasbehaModel.id);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.sizeOf(context).height / 5,
                            width: MediaQuery.sizeOf(context).width / 5,
                            // padding: const EdgeInsets.all(32),
                            decoration: const ShapeDecoration(
                              color: Color(0xff365C5E),
                              shape: CircleBorder(),
                            ),
                            child: Text(
                              "${mesbahaController.times.value}",
                              style: TextThemes.timesTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      mesbahaController.times.value = 0;
                    },
                    icon: const Icon(CupertinoIcons.refresh_thick),
                  ),
                  const Spacer(),
                  WaveWidget(
                    config: CustomConfig(durations: [
                      9000,
                      3000,
                      2000,
                      4000,
                    ], heightPercentages: [
                      -1,
                      -1,
                      -1,
                      -1,
                    ], colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.8),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.6),
                      Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.4),
                    ]),
                    size: Size(MediaQuery.of(context).size.width, 25),
                    waveAmplitude: 0,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
