import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:islamic_app/text_themes.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(
      {super.key, required this.title, required this.svgIcon, this.onTap});
  final String title;
  final Widget svgIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            const Spacer(),
            svgIcon,
            Gap(8.h),
            Text(
              title,
              style: TextThemes.sectionsTextStyle(context),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
