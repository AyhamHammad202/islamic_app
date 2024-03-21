import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/menu_extension.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

import 'custom_aya_span.dart';

class AyatOfPage extends StatelessWidget {
  const AyatOfPage({
    super.key,
    required this.ayas,
    required this.quranController,
    required this.page,
  });

  final List<AyaOfSurahModel> ayas;
  final QuranController quranController;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RichText(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'page${page + 1}',
            fontSize: 100,
            letterSpacing: .01,
            wordSpacing: .01,
            // height: 1.9,
            color: Colors.black,
          ),
          children: List.generate(ayas.length, (ayaIndex) {
            quranController.isSelected = quranController.selectedAyahIndexes
                .contains(ayas[ayaIndex].uniqueIdOfAya);
            return span(
                text: ayas[ayaIndex].text,
                pageIndex: page,
                isSelected: quranController.isSelected,
                uniqueAyaId: ayas[ayaIndex].uniqueIdOfAya,
                // fontSize: 18.sp,
                surahNum: quranController
                    .surahs[
                        quranController.getSurahNumberByAya(ayas[ayaIndex]) - 1]
                    .numberOfSurah,
                ayahNum: ayas[ayaIndex].numberOfAyaInSurah,
                onLongPressStart: (LongPressStartDetails details) {
                  quranController
                      .toggleAyahSelection(ayas[ayaIndex].uniqueIdOfAya);
                  context.showAyahMenu(
                    quranController.getSurahNumberFromPage(page),
                    page,
                    ayaIndex,
                    details: details,
                    ayaOfSurahModel: ayas[ayaIndex],
                  );
                },
                isFirstAyah: ayaIndex == 0);
          }),
        ),
      );
    });
  }
}
