import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/models/radio_model.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/radio/quran_radio_view.dart';

class RadioChannel extends StatelessWidget {
  const RadioChannel({super.key, required this.radioModel});
  final RadioModel radioModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          // audioController.currentRadioChannelIndex.value = index;
          Get.to(
            () => QuranRadioView(radioModel: radioModel),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicturesMethods.micIcon(height: 80.h),
                Gap(4.h),
                Text(
                  Get.locale == const Locale('ar')
                      ? radioModel.arabicName
                      : radioModel.englishName,
                  style: TextThemes.radioChannelTextStyle(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
