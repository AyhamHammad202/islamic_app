import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/version_one_views/widgets/custom_botton.dart';
import 'package:islamic_app/version_one_views/widgets/tafser_bottomsheet.dart';
import 'package:share_plus/share_plus.dart';

class AyaItemAbove extends StatelessWidget {
  const AyaItemAbove({
    super.key,
    required this.aya,
    required this.indexOfAyaInPage,
  });

  final AyaOfSurahModel aya;
  final int indexOfAyaInPage;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: kThirdlyColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("assets/images/frame_arrow.svg"),
                SvgPicture.asset("assets/images/frame_back_comp.svg"),
                SvgPicture.asset("assets/images/frame_colored.svg"),
                Text(
                  aya.numberOfAyaInSurah.toArabic(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                quranController
                    .surahs[quranController.getSurahNumberByAya(aya) - 1]
                    .nameOfSurah,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: kFontKufamItalicVariableFont,
                  fontSize: 16.sp,
                ),
              ),
            ),
            const Spacer(),
            CustomBotton(
              image: "assets/images/copyyy.png",
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                  text:
                      "﴿ ${aya.textOfAya} ﴾\n${quranController.surahs[quranController.getSurahNumberByAya(aya) - 1].nameOfSurah} الآية:${aya.numberOfAyaInSurah}",
                ));
                if (context.mounted) {
                  show(context: context, message: "تم النسخ");
                }
              },
            ),
            CustomBotton(
              image: "assets/images/sharee.png",
              onTap: () {
                Share.share(
                    "﴿ ${aya.textOfAya} ﴾\n${quranController.surahs[quranController.getSurahNumberByAya(aya) - 1].nameOfSurah} الآية:${aya.numberOfAyaInSurah}\nالتفسير:${quranController.mapOfTafser[aya.uniqueIdOfAya]}");
              },
            ),
            CustomBotton(
              image: "assets/svg/tafsir_icon.svg",
              isSvg: true,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return TafserBottomSheet(
                      // tafser: quranController
                      //     .tafserOfPage[indexOfAyaInPage],
                      tafser: quranController.mapOfTafser[aya.uniqueIdOfAya]!,
                      ayaOfSurahModel: aya,
                      page: aya.page - 1,
                      numberOfSura: quranController.getSurahNumberByAya(aya),
                      numberOfAyaInPage: indexOfAyaInPage,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
