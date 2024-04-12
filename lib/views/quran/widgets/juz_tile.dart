import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/text_themes.dart';

class JuzTile extends StatelessWidget {
  const JuzTile({
    super.key,
    required this.juz,
    this.onTap,
  });

  final AyaOfSurahModel juz;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${S.of(context).juz} ${juz.juz}",
                  style: TextThemes.juzTextStyle,
                ),
                const Spacer(),
                Text(
                  "${S.of(context).page} ${juz.page.toString().padLeft(3, "0")}",
                  style: TextThemes.juzPageTextStyle,
                ),
                Gap(32.w)
              ],
            ),
            Row(
              children: [
                Text(
                  "۞",
                  style: TextThemes.juzTextStyle,
                ),
                Gap(4.w),
                Expanded(
                  child: Text(
                    juz.searchTextOfAya,
                    style: TextThemes.ayaOfJuzTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
