import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

class Bassmalah extends StatelessWidget {
  const Bassmalah(
      {super.key, required this.aya, required this.quranController});
  final AyaOfSurahModel aya;
  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return quranController.getSurahNumberByAya(aya) == 9 ||
            quranController.getSurahNumberByAya(aya) == 1
        ? const SizedBox.shrink()
        : SvgPicture.asset(
            quranController.getSurahNumberByAya(aya) == 95 ||
                    quranController.getSurahNumberByAya(aya) == 97
                ? "assets/images/design/besmAllah2.svg"
                : "assets/images/design/besmAllah.svg",
            width: MediaQuery.of(context).size.width / 2,
          );
  }
}
