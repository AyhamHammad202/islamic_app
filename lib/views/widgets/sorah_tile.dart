import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat_view.dart';

class SorahTile extends StatelessWidget {
  const SorahTile({super.key, required this.sorah});
  final SurahModel sorah;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    LastReadService settingsService = Get.find();

    return InkWell(
      onTap: () {
        quranController.globalPage.value = sorah.ayas[0].page - 1;
        quranController.getCurrentPageAyas(sorah.ayas.first.page - 1);
        Navigator.pushNamed(context, AyatView.id, arguments: sorah);
        settingsService.setLastRead(
          sorah.ayas.first.page,
          "${DateTime.now().day.toArabic()}/${DateTime.now().month.toArabic()}/${DateTime.now().year.toArabic()}",
          sorah.numberOfSurah,
          sorah.ayas.first.numberOfAyaInSurah,
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: sorah.numberOfSurah % 2 == 0
                  ? kSecondlyColor.withOpacity(0.1)
                  : kSecondlyColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(
                  sorah.numberOfSurah % 2 == 0 ? 8.r : 4.r),
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      kSorahNumberFramAsset,
                      width: 50.w,
                    ),
                    Text(
                      sorah.numberOfSurah.toArabic(),
                      style: TextStyle(
                        fontFamily: kFontKufamRegular,
                        color: kThirdlyColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/images/sorahs/00${sorah.numberOfSurah}.svg",
                  // color: kThirdlyColor,
                  colorFilter:
                      const ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
                  width: 100.w,
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      sorah.englishNameOfSurah,
                      style: TextStyle(
                        color: kThirdlyColor,
                        fontFamily: kFontKufamRegular,
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          sorah.revelationType,
                          style: TextStyle(
                            color: kSecondlyColor,
                            fontFamily: kFontKufamRegular,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                          child: VerticalDivider(
                            color: kSecondlyColor,
                            width: 10.w,
                            thickness: 1.5,
                          ),
                        ),
                        Text(
                          "${sorah.ayas.length} آية",
                          style: TextStyle(
                            color: kSecondlyColor,
                            fontFamily: kFontKufamRegular,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            indent: 50.w,
            endIndent: 50.w,
            height: 2.h,
            color: kSecondlyColor,
          ),
        ],
      ),
    );
  }
}
