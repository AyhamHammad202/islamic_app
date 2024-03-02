import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

class JuzTile extends StatelessWidget {
  const JuzTile({
    super.key,
    required this.juz, this.onTap,
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(),
                Text(
                  "${S.of(context).page} ${juz.page.toString().padLeft(3, "0")}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Gap(32.w)
              ],
            ),
            Row(
              children: [
                Text(
                  "۞",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Gap(4.w),
                Expanded(
                  child: Text(
                    juz.searchTextOfAya,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
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
