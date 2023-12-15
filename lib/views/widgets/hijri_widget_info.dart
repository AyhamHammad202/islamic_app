import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../constant.dart';
import '../../helper.dart';

class HijriWidgetInfo extends StatelessWidget {
  const HijriWidgetInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    var hijri = new HijriCalendar.now();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: kForthColor,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${hijri.hDay.toArabic()}",
              // "${29.toArabic()}",
              style: TextStyle(
                color: kThirdlyColor,
                fontSize: 72.sp,
                fontWeight: FontWeight.w600,
                fontFamily: kFontNotoNaskhArabic,
                height: 1,
              ),
            ),
            SizedBox(
              height: 40.h,
              child: VerticalDivider(
                color: kThirdlyColor,
                thickness: 2,
              ),
            ),
            // Text(
            //   hijri.longMonthName,
            //   style: TextStyle(
            //     fontFamily: kFontKufamItalicVariableFont,
            //     fontSize: 24.sp,
            //     height: 1,
            //   ),
            // ),
            SvgPicture.asset(
              fromHijriIndexToImage(hijri.hMonth),
              colorFilter: ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${hijri.hMonth.toArabic()}",
                  style: TextStyle(
                    color: kThirdlyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp,
                    fontFamily: kFontNotoNaskhArabic,
                    height: 0.2,
                  ),
                ),
                SizedBox(
                  width: 50.w,
                  child: Divider(
                    color: kSecondlyColor,
                    thickness: 2,
                    height: 10,
                  ),
                ),
                Text(
                  "${hijri.hYear.toArabic()} هـ",
                  style: TextStyle(
                    color: kThirdlyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 33.sp,
                    fontFamily: kFontNotoNaskhArabic,
                    height: 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
