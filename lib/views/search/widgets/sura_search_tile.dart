import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:quran_library/quran.dart';

import '../../ayat/ayat_view.dart';

class SuraSearchTile extends StatelessWidget {
  const SuraSearchTile({
    super.key,
    required this.ayahModel,
  });

  final AyahModel ayahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return InkWell(
      onTap: () {
        // quranController.globalPage.value = ayahModel.ayahs[0].page - 1;
        // quranController.getCurrentPageAyas(ayahModel.ayahs.first.page - 1);
        Get.to(
          AyatView(
              // surahModel: quranController.surahs[ayahModel.surahNumber!],
              ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
        QuranLibrary().jumpToSurah(ayahModel.surahNumber!);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(.6),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${S.of(context).sorah}: ${ayahModel.surahNumber!.toArabic()}",
              style: TextThemes.searchInfoTextStyle(context),
            ),
            const Gap(8),
            Text(
              quranController.surahs[ayahModel.surahNumber! - 1].arabicName,
              style: TextThemes.searchSuraTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }
}
