import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/ayat_view.dart';
import 'package:islamic_app/views/quran/widgets/sura_tile.dart';

class SurasSliverList extends StatelessWidget {
  const SurasSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final LastReadService lastReadService = Get.find();
    return AnimationLimiter(
      child: SliverList.builder(
        itemCount: quranController.surahs.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 450),
            child: SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: SuraTile(
                  index: index,
                  onTap: () {
                    quranController.globalPage.value =
                        quranController.surahs[index].ayas[0].page - 1;
                    quranController.getCurrentPageAyas(
                        quranController.surahs[index].ayas.first.page - 1);
                    Get.to(
                      AyatView(
                        surahModel: quranController.surahs[index],
                      ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                    lastReadService.setLastRead(
                      quranController.surahs[index].ayas.first.page,
                      "${DateTime.now()}",
                      quranController.surahs[index].numberOfSurah,
                      quranController
                          .surahs[index].ayas.first.numberOfAyaInSurah,
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
