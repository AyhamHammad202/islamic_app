import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

import '../../surah_info/surah_info_view.dart';

class SuraBannerWithName extends StatelessWidget {
  const SuraBannerWithName({
    super.key,
    required this.aya,
    required this.quranController,
  });

  final AyaOfSurahModel aya;
  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Get.to(
          () => SurahInfoView(
            surahModel: quranController
                .surahs[quranController.getSurahNumberByAya(aya) - 1],
          ),
          transition: Transition.leftToRight,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: aya.numberOfAyaInSurah == 1
          ? Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/design/Sorah_name_ba3.svg",
                  width: MediaQuery.of(context).size.width,
                  // height: 200.h,
                  // width: MediaQuery.of(context).size.width,
                  // fit: BoxFit.fill,
                ),
                SvgPicture.asset(
                  "assets/images/sorahs/00${quranController.getSurahNumberByAya(aya)}.svg",
                  width: MediaQuery.sizeOf(context).width / 4,
                  // height: 250.h,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class LastBannar extends StatelessWidget {
  const LastBannar({
    super.key,
    required this.aya,
    required this.quranController,
  });

  final AyaOfSurahModel aya;
  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return Constant.lastPlaceBannerPageIndex.contains(aya.page)
        ? InkWell(
            onLongPress: () {
              Get.to(
                () => SurahInfoView(
                  surahModel: quranController
                      .surahs[quranController.getSurahNumberByAya(aya)],
                ),
                transition: Transition.leftToRight,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/design/Sorah_name_ba3.svg",
                  width: MediaQuery.sizeOf(context).width - 16.w,
                ),
                SvgPicture.asset(
                  "assets/images/sorahs/00${quranController.getSurahNumberByAya(aya) + 1}.svg",
                  width: MediaQuery.sizeOf(context).width / 4,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
