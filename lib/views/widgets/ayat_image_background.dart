import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyatImageBackground extends StatelessWidget {
  const AyatImageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.5,
          margin: EdgeInsets.only(right: 4.w, top: 32.h, bottom: 32.h),
          decoration: BoxDecoration(
            color: Color(0xffB5A397),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.5,
          margin: EdgeInsets.only(right: 8.w, top: 32.h, bottom: 32.h),
          decoration: BoxDecoration(
            color: Color(0xffD8C4B6),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.5,
          margin: EdgeInsets.only(right: 12.w, top: 32.h, bottom: 32.h),
          decoration: BoxDecoration(
            color: Color(0xffF5EFE7),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }
}
