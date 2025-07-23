import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/ayat/ayat_view.dart';
import 'package:quran_library/quran.dart';

class LastReadAya extends StatelessWidget {
  const LastReadAya({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LastReadService lastReadService = Get.find();
    QuranController quranController = Get.find();
    var formatter = DateFormat(
      'd MMMM',
      // 'ar_SA',
    ); // 'd MMMM' represents the desired format
    String formattedDate = formatter.format(
      DateTime.tryParse(lastReadService.lastDateRead.value) ?? DateTime.now(),
    ); // Format the current date
    return GetX<LastReadService>(builder: (service) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            // audioController.ayaUniqeId.value = quranController
            //     .pages[lastReadService.lastPageRead.value - 1]
            //     .first
            //     .uniqueIdOfAya;
            // quranController.globalPage.value =
            //     lastReadService.lastPageRead.value - 1;
            // quranController
            //     .getCurrentPageAyas(lastReadService.lastPageRead.value - 1);
            Get.to(
              AyatView(),
              transition: Transition.upToDown,
              duration: const Duration(milliseconds: 300),
            );
            QuranLibrary().jumpToAyah(lastReadService.lastPageRead.value,
                lastReadService.lastAyaUniqeNumRead.value);
          },
          child: Stack(
            // alignment: Alignment.center,
            children: [
              SvgPicturesMethods.lastReadBackgroundIcon(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height / 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicturesMethods.lastReadIcon(),
                    SizedBox(width: 16.w),
                    Text(
                      S.current.lastRead,
                      style: TextThemes.lastReadTextStyle(context),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .1),
                    Text(
                      formattedDate,
                      style: TextThemes.lastInfoTextStyle(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 70.h,
                right: 16.w,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      quranController
                          .surahs[lastReadService.lastSuraNumRead.value - 1]
                          .arabicName,
                      style: TextThemes.lastSuraNameTextStyle(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 110.h,
                right: 16.w,
                child: Row(
                  children: [
                    Text(
                      "${S.of(context).lastReadVarseNum} ${lastReadService.lastAyaNumRead.value}",
                      style: TextThemes.lastInfoTextStyle(context),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .24),
                    Text(
                      "${S.of(context).page}: ${lastReadService.lastPageRead.value}",
                      style: TextThemes.lastInfoTextStyle(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 25.w,
                top: 40.h,
                child: SvgPicturesMethods.quranBookIcon(height: 50.h),
              ),
            ],
          ),
        ),
      );
    });
  }
}
