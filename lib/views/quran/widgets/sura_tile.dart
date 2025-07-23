import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/surah_info/surah_info_view.dart';
import 'package:quran_library/quran_library.dart';

class SuraTile extends StatelessWidget {
  const SuraTile({
    super.key,
    required this.index,
    this.onTap,
  });

  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicturesMethods.suraNumBorderIcon(),
                  Text(
                    quranController.surahs[index].surahNumber.toArabic(),
                    style: TextThemes.suraNumTextStyle(context),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/sorahs/00${quranController.surahs[index].surahNumber}.svg",
                height: 42.h,
                width: 100.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xffD7A664),
                  BlendMode.srcIn,
                ),
              ),
              const Spacer(),
              Text(
                "${quranController.surahs[index].ayahs.length.toString().padLeft(3, '0')} - ",
                style: TextThemes.suraInfoTextStyle(context),
              ),
              Gap(4.h),
              Text(
                QuranLibrary().getSurahInfo(surahNumber: index).revelationType,
                style: TextThemes.suraInfoTextStyle(context),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  Get.to(
                    () => SurahInfoView(
                      surahModel: quranController.surahs[index],
                    ),
                    transition: Transition.leftToRight,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: SvgPicturesMethods.alertCircleIcon(),
              ),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      ),
    );
  }
}
