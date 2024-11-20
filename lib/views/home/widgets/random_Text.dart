import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:islamic_app/text_themes.dart';

class RandomText extends StatelessWidget {
  const RandomText({
    super.key,
    required this.title,
    required this.subTitle,
    required this.content,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final String content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 100.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.7),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "$title: $subTitle",
                style: TextThemes.quranDuaaTitleTextStyle(context),
              ),
              const Spacer(),
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.refresh),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Theme.of(context).dividerColor,
          ),
          Gap(8.h),
          AnimatedCrossFade(
            sizeCurve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            crossFadeState: CrossFadeState.showSecond,
            firstChild: const SizedBox(),
            secondChild: Text(
              content,
              style: TextThemes.quranDuaaTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
