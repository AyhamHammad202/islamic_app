import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    int leftDays = quranController.calculate(year, month, day);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          children: [
            LinearProgressIndicator(
              value: (1.0 - (leftDays / 365)).clamp(0.0, 1.0),
              minHeight: MediaQuery.sizeOf(context).height / 13,
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(1),
              // color: Colors.red,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height / 13,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicturesMethods.occasionIcon(),
                    Gap(8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(8.h),
                        Text(
                          occasionTitle,
                          style: TextThemes.occasionTextStyle(context),
                        ),
                        Expanded(
                          child: Text(
                            Localizations.localeOf(context).languageCode == "ar"
                                ? "${year.toArabic()}/${month.toArabic()}/${day.toArabic()}"
                                : "$year/$month/$day",
                            style: TextThemes.occasionStatueTextStyle(context),
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
      ),
    );
  }
}
