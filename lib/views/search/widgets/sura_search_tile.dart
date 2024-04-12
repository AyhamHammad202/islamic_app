import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/text_themes.dart';

import '../../../controllers/quran_controller.dart';
import '../../ayat/ayat_view.dart';

class SuraSearchTile extends StatelessWidget {
  const SuraSearchTile({
    super.key,
    required this.surahModel,
  });

  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return InkWell(
      onTap: () {
        quranController.globalPage.value = surahModel.ayas[0].page - 1;
        quranController.getCurrentPageAyas(surahModel.ayas.first.page - 1);
        Get.to(
          AyatView(
            surahModel: surahModel,
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
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
              "${S.of(context).sorah}: ${surahModel.numberOfSurah.toArabic()}",
              style: TextThemes.searchInfoTextStyle,
            ),
            const Gap(8),
            Text(
              surahModel.nameOfSurah,
              style: TextThemes.searchSuraTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
