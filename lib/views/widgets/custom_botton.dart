import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';

class CustomBotton extends StatelessWidget {
  const CustomBotton({
    Key? key,
    this.onTap,
    required this.image,
  }) : super(key: key);
  final void Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Container(
            decoration: BoxDecoration(
                color: kSecondlyColor,
                borderRadius: BorderRadius.circular(8.r)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                image,
                color: Colors.black,
              ),
            )),
      ),
      onTap: onTap,
    );
  }
}
