import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/views/home/widgets/random_Text.dart';

import '../../generated/l10n.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/last_read_aya.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    var hijri = HijriCalendar.now();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: HomeAppBar(hijri: hijri),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LastReadAya(),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Constant.homeSections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => Constant.homeSections[index],
                ),
                GetBuilder<QuranController>(builder: (quranController) {
                  return RandomText(
                    title: S.current.randomAya,
                    subTitle:
                        "${quranController.surahs[quranController.getSurahNumberByAya(quranController.allAyas[quranController.randomAya.value]) - 1].nameOfSurah}: ${quranController.allAyas[quranController.randomAya.value].numberOfAyaInSurah}",
                    content: quranController
                        .allAyas[quranController.randomAya.value].textOfAya,
                    onTap: quranController.randomAyaSelect,
                  );
                }),
                GetBuilder<QuranController>(builder: (quranController) {
                  return RandomText(
                    title: S.current.quranDuaas,
                    subTitle: quranController
                        .quranDuaas[quranController.randomSura.value].sura,
                    content: quranController
                        .quranDuaas[quranController.randomSura.value]
                        .ayas[quranController.randomAyaFromSura.value]
                        .duaa,
                    onTap: quranController.randomDuaa,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
