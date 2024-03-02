import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:islamic_app/constants/constant.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({
    super.key,
    this.onTap,
    this.image = "",
    this.isSvg = false,
  });
  final void Function()? onTap;
  final String image;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Container(
          decoration: BoxDecoration(
              color: kSecondlyColor, borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: isSvg
                ? SvgPicture.asset(
                    image,
                  )
                : Image.asset(
                    image,
                    color: Colors.black,
                  ),
          ),
        ),
      ),
    );
  }
}
