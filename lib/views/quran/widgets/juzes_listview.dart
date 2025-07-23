import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/ayat_view.dart';
import 'package:islamic_app/views/quran/widgets/juz_tile.dart';
import 'package:quran_library/quran_library.dart';

class JuzesListView extends StatelessWidget {
  const JuzesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final AudioController audioController = Get.find();
    final LastReadService lastReadService = Get.find();
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          AyahModel juz =
              quranController.ayas.firstWhere((a) => a.juz == index + 1);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: JuzTile(
                  juz: juz,
                  onTap: () {
                    Get.to(
                      AyatView(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                    QuranLibrary().jumpToAyah(juz.page, juz.ayahUQNumber);
                    lastReadService.updateLastRead(juz);
                    // quranController.globalPage.value = juz.page - 1;
                    // quranController.surahs[index].ayas[0].page - 1;
                    // quranController.getCurrentPageAyas(
                    //   juz.page - 1,
                    // );
                    audioController.ayaUniqeId.value = juz.ayahUQNumber;
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
