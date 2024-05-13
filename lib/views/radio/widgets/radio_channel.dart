import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/radio/quran_radio_view.dart';

class RadioChannel extends StatelessWidget {
  const RadioChannel({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          audioController.currentRadioChannelIndex.value = index;
          Get.to(
            () => const QuranRadioView(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Row(
              children: [
                Text(
                  Constant.radioNames[index],
                  style: TextThemes.radioChannelTextStyle(context),
                ),
                const Spacer(),
                SvgPicturesMethods.playAudioIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
