import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    super.key,
    required this.title,
    this.isSelected = false,
  });
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Color(0xffca9b79) : Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: kFontKufamRegular,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
