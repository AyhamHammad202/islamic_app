import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/constant.dart';

class LastSorahReadWidget extends StatelessWidget {
  const LastSorahReadWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "assets/images/sorahs/002.svg",
                  colorFilter: ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
                  width: 130.w,
                ),
                Text(
                  "Al-Baqarah",
                  style: TextStyle(
                    color: kThirdlyColor,
                    fontFamily: kFontNotoNaskhArabic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
              child: VerticalDivider(
                color: kThirdlyColor,
                width: 2,
                thickness: 2,
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  "2023/12/15",
                  style: TextStyle(
                    color: kThirdlyColor,
                    fontFamily: kFontNotoNaskhArabic,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  "الآية - 16",
                  style: TextStyle(
                    color: kThirdlyColor,
                    fontFamily: kFontNotoNaskhArabic,
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
            SizedBox(width: 32.w),
          ],
        ),
      ),
    );
  }
}
