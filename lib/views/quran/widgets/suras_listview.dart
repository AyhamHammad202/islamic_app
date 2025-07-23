import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/ayat_view.dart';
import 'package:islamic_app/views/quran/widgets/sura_tile.dart';
import 'package:quran_library/quran_library.dart';

class SurasListView extends StatelessWidget {
  const SurasListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final AudioController audioController = Get.find();
    final LastReadService lastReadService = Get.find();
    return AnimationLimiter(
      child: ListView.builder(
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
                    Get.to(
                      AyatView(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                    QuranLibrary().jumpToSurah(index + 1);
                    lastReadService.updateLastRead(
                        quranController.surahs[index].ayahs.first);
                    // quranController.globalPage.value =
                    //     quranController.surahs[index].ayas[0].page - 1;
                    // quranController.getCurrentPageAyas(
                    //     quranController.surahs[index].ayas.first.page - 1);
                    audioController.ayaUniqeId.value =
                        quranController.surahs[index].ayahs.first.ayahUQNumber;
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
