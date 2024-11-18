import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/text_themes.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelected,
  });
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(isSelected ? 8.r : 4.r)),
        child: Center(
          child: Text(
            title,
            style: TextThemes.tabTextStyle(context).copyWith(
              color: isSelected
                  ? TextThemes.tabTextStyle(context).color
                  : TextThemes.tabTextStyle(context).color!.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }
}
