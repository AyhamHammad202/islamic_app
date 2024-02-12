import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/views/ayat_view.dart';

class SorahTile extends StatelessWidget {
  const SorahTile({super.key, required this.sorah});
  final SurahModel sorah;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: InkWell(
        onTap: () {
          globalPage = sorah.ayas[0].page - 1;
          quranController.getCurrentPageAyas(sorah.ayas.first.page - 1);
          Navigator.pushNamed(context, AyatView.id, arguments: sorah);
          // BlocProvider.of<QuranCubit>(context).getCurrentPageSora(sorah.pageNum);
          // // BlocProvider.of<QuranCubit>(context).getAllAyatOfPage(sorah.pageNum);
          // BlocProvider.of<QuranCubit>(context).setLastRead(sorah.pageNum);
          // BlocProvider.of<QuranCubit>(context).getLastRead();
          // BlocProvider.of<QuranCubit>(context).getAyatOfLastRead(sorah.pageNum);
          // Navigator.pushNamed(context, AyatView.id, arguments: sorah);
        },
        child: Container(
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    kSorahNumberFramAsset,
                  ),
                  Text(
                    "${sorah.numberOfSurah.toArabic()}",
                    style: TextStyle(
                      fontFamily: kFontKufamRegular,
                      color: kThirdlyColor,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/sorahs/${sorah.numberOfSurah.toString().padLeft(3, "0")}.svg",
                // color: kThirdlyColor,
                colorFilter: ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
                width: 100.w,
              ),
              Spacer(),
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
                        "${sorah.revelationType}",
                        style: TextStyle(
                          color: kSecondlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 14.sp,
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
                          fontSize: 14.sp,
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
      ),
    );
  }
}
