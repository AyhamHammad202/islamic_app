import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:quran_library/quran_library.dart';

import '../../ayat/ayat_view.dart';

class AyaSearchTile extends StatelessWidget {
  const AyaSearchTile({
    super.key,
    required this.aya,
  });

  final AyahModel aya;

  @override
  Widget build(BuildContext context) {
    Get.find();
    Get.find();
    return InkWell(
      onTap: () {
        // quranController.globalPage.value = aya.page - 1;
        // quranController.getCurrentPageAyas(aya.page - 1);
        // quranController.selectedAyahIndexes.add(aya.uniqueIdOfAya);
        // audioController.ayaUniqeId.value = aya.uniqueIdOfAya;
        // quranController.globalPage.value = aya.page - 1;
        // quranController.getCurrentPageAyas(aya.page - 1);
        Get.to(
          AyatView(
          ),
          transition: Transition.upToDown,
          duration: const Duration(milliseconds: 300),
        );
        QuranLibrary().jumpToAyah(aya.page, aya.ayahUQNumber);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(.6),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary.withOpacity(.6),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8.h),
            Text(
              aya.ayaTextEmlaey,
              style: TextThemes.searchAyaTextStyle(context),
            ),
            Gap(8.h),
            Text(
              "${aya.arabicName}, ${S.current.aya}:${aya.ayahNumber}",
              style: TextThemes.searchInfoTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
