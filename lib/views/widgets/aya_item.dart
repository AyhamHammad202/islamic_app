import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/models/aya_model.dart';

class AyaItem extends StatelessWidget {
  const AyaItem({
    super.key,
    required this.ayat,
  });

  final AyatModel ayat;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Text(
              ayat.ayaText,
              style: TextStyle(
                fontFamily: kFontUthmanicHafs,
                color: kThirdlyColor,
                fontSize: 28.sp,
              ),
            ),
            Text(
              ayat.taffser,
              style: TextStyle(
                fontFamily: kFontKufamItalic,
                color: kThirdlyColor,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
