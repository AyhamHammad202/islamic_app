import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/models/surah_model.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return SafeArea(
      child: GetBuilder<QuranController>(
        builder: (controller) {
          return SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  quranController.surasFoundbySearch.length,
                  (index) => SuraSearchTile(
                    surahModel: quranController.surasFoundbySearch[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AyaSearchTile extends StatelessWidget {
  const AyaSearchTile({
    super.key,
    required this.ayaOfSurahModel,
  });

  final AyaOfSurahModel ayaOfSurahModel;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return Column(
      children: [
        Text(
          quranController
              .surahs[quranController.getSurahNumberByAya(ayaOfSurahModel) - 1]
              .nameOfSurah,
        ),
        Text(
          ayaOfSurahModel.textOfAya,
          style: const TextStyle(
            fontFamily: kFontUthmanicHafs,
          ),
        ),
      ],
    );
  }
}

class SuraSearchTile extends StatelessWidget {
  const SuraSearchTile({
    super.key,
    required this.surahModel,
  });

  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            surahModel.nameOfSurah,
            style: const TextStyle(
              fontFamily: kFontNotoNaskhArabic,
            ),
          ),
        ],
      ),
    ));
  }
}
