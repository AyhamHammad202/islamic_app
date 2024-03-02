import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';

class SuraBannerWithName extends StatelessWidget {
  const SuraBannerWithName({
    super.key,
    required this.aya,
    required this.quranController,
  });

  final AyaOfSurahModel aya;
  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        aya.numberOfAyaInSurah == 1
            ? Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/images/design/Sorah_name_ba3.svg"),
                  SvgPicture.asset(
                      "assets/images/sorahs/00${quranController.getSurahNumberByAya(aya)}.svg"),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class LastBannar extends StatelessWidget {
  const LastBannar({
    super.key,
    required this.aya,
    required this.quranController,
  });

  final AyaOfSurahModel aya;
  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return aya.page == 76
        ? Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset("assets/images/design/Sorah_name_ba3.svg"),
              SvgPicture.asset(
                  "assets/images/sorahs/00${quranController.getSurahNumberByAya(aya) + 1}.svg"),
            ],
          )
        : const SizedBox.shrink();
  }
}

