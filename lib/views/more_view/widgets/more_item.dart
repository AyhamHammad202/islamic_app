import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/text_themes.dart';

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });
  final String title;
  final Widget leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.4),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        leading: SizedBox(
          height: 24.h,
          width: 24.w,
          child: leading,
        ),
        title: Text(
          title,
          style: TextThemes.moreItemTextStyle(context),
        ),
        onTap: onTap,
      ),
    );
  }
}
