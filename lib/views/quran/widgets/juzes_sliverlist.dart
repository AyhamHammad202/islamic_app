import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/ayat_view.dart';
import 'package:islamic_app/views/quran/widgets/juz_tile.dart';

class JuzesSliverList extends StatelessWidget {
  const JuzesSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final LastReadService lastReadService = Get.find();
    return AnimationLimiter(
      child: SliverList.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          AyaOfSurahModel juz =
              quranController.allAyas.firstWhere((a) => a.juz == index + 1);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: JuzTile(
                  juz: juz,
                  onTap: () {
                    quranController.globalPage.value = juz.page - 1;
                    // quranController.surahs[index].ayas[0].page - 1;
                    quranController.getCurrentPageAyas(
                      juz.page - 1,
                    );
                    Get.to(
                      AyatView(
                        surahModel: quranController.surahs[
                            quranController.getSurahNumberByAya(juz) - 1],
                      ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                    lastReadService.setLastRead(
                      juz.page,
                      "${DateTime.now()}",
                      quranController
                          .surahs[quranController.getSurahNumberByAya(juz) - 1]
                          .numberOfSurah,
                      juz.numberOfAyaInSurah,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
