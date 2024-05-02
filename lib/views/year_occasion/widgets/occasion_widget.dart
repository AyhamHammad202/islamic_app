import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';

class OccasionWidget extends StatelessWidget {
  const OccasionWidget(
      {super.key,
      required this.occasionTitle,
      required this.year,
      required this.month,
      required this.day});
  final String occasionTitle;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    int leftDays = quranController.calucate(year, month, day);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Stack(
        children: [
          Container(
            width: quranController.calculateProgress2(
              HijriCalendar.now().hDay,
              leftDays,
              MediaQuery.sizeOf(context).width,
            ),
            height: MediaQuery.sizeOf(context).height / 13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height / 13,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 8.w),
              child: Row(
                children: [
                  SvgPicturesMethods.occasionIcon(),
                  Gap(8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        occasionTitle,
                        style: TextThemes.occasionTextStyle(context),
                      ),
                      FittedBox(
                        child: Text(
                          Localizations.localeOf(context).languageCode == "ar"
                              ? "${year.toArabic()}/${month.toArabic()}/${day.toArabic()}"
                              : "$year/$month/$day",
                          style: TextThemes.occasionDateTextStyle(context),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    leftDays == 0
                        ? S.of(context).hasCome
                        : "${Localizations.localeOf(context).languageCode == "ar" ? leftDays.toArabic() : leftDays}\n${leftDays > 2 ? S.of(context).days : S.of(context).day}",
                    textAlign: TextAlign.center,
                    style: TextThemes.occasionStatueTextStyle(context),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
