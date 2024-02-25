
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/widgets/aya_item.dart';
import 'ayat_image_page_view.dart';

class AyatTextPageView extends StatelessWidget {
  const AyatTextPageView({super.key, required this.sorah});
  final SurahModel sorah;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    LastReadService settingsService = Get.find();
    return PageView.builder(
      controller: quranController.pageController,
      itemCount: 604,
      onPageChanged: (page) {
        settingsService.setLastRead(
          page + 1,
          "${DateTime.now().day.toArabic()}/${DateTime.now().month.toArabic()}/${DateTime.now().year.toArabic()}",
          quranController
              .getSurahNumberByAya(quranController.pages[page].first),
          quranController.pages[page].first.numberOfAyaInSurah,
        );
        quranController.globalPage.value = page;
      },
      itemBuilder: (context, page) {
        quranController.getCurrentPageAyahsSeparatedForBasmala(page);
        // quranController.getAyaTafser(page + 1);
        // List<AyatModel> ayat =
        //     BlocProvider.of<QuranCubit>(context).ayatOfPage!;
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
                quranController
                    .getCurrentPageAyahsSeparatedForBasmala(page)
                    .length, (i) {
              final ayas = quranController
                  .getCurrentPageAyahsSeparatedForBasmala(page)[i];
              return Column(
                children: [
                  SuraBannerWithName(
                      ayas: ayas, quranController: quranController),
                  Column(
                    children: List.generate(
                      ayas.length,
                      (index) =>
                          AyaItem(aya: ayas[index], numOfAyaInPage: index),
                    ),
                  )
                ],
              );
            }),
          ),
        );
        // AyatTextListView(ayat: ayat);
      },
    );
  }
}
