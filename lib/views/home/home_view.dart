import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/views/home/widgets/last_read_aya.dart';
import 'package:islamic_app/views/quran/quran_view.dart';
import 'package:islamic_app/views/search/search_view.dart';

import 'widgets/section_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    var hijri = HijriCalendar.now();

    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicturesMethods.calendarIcon(),
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  "${hijri.dayWeName}, ${hijri.hDay.toArabic()} ${hijri.longMonthName} ${hijri.hYear.toArabic()} هـ",
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => const SearchView(),
                      transition: Transition.upToDown,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  child: SvgPicturesMethods.searchIcon(height: 15.h),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SvgPicturesMethods.menuIcon(height: 10.h),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LastReadAya(),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    SectionWidget(
                      title: S.of(context).quran,
                      svgIcon: SvgPicturesMethods.quranBookIcon(
                        height: 75,
                        width: 75,
                      ),
                      onTap: () {
                        Get.put(() => GeneralController());
                        Get.to(
                          () => const QuranView(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
