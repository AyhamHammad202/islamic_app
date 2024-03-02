import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

import '../../ayat/ayat_view.dart';

class AyaSearchTile extends StatelessWidget {
  const AyaSearchTile({
    super.key,
    required this.aya,
  });

  final AyaOfSurahModel aya;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return InkWell(
      onTap: () {
        quranController.globalPage.value = aya.page - 1;
        quranController.getCurrentPageAyas(aya.page - 1);
        quranController.selectedAyahIndexes.add(aya.uniqueIdOfAya);
        Get.to(
          AyatView(
            surahModel: quranController
                .surahs[quranController.getSurahNumberByAya(aya) - 1],
          ),
          transition: Transition.upToDown,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(.5),
            )),
        child: Text(
          aya.searchTextOfAya,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
