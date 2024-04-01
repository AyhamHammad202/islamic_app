import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';

class DownloadAyat extends StatelessWidget {
  const DownloadAyat({super.key});

  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.find();
    QuranController quranController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.downloadAyat),
        ),
        body: ListView.builder(
          itemCount: quranController.surahs.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 450),
              child: SlideAnimation(
                horizontalOffset: 50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(context).showBottomSheet(
                          (context) => ListView.builder(
                            itemCount:
                                quranController.surahs[index].ayas.length,
                            itemBuilder: (context, indexAya) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<bool>(
                                    future: audioController.isAyaDownloaded(
                                        quranController
                                            .surahs[index].ayas[indexAya]),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Text("");
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          await audioController.downloadAya(
                                              quranController.surahs[index]
                                                  .ayas[indexAya]);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                quranController
                                                    .surahs[index]
                                                    .ayas[indexAya]
                                                    .numberOfAyaInSurah
                                                    .toArabic(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Text(
                                                snapshot.data! ? "نعم" : "لا",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicturesMethods.suraNumBorderIcon(),
                                Text(
                                  quranController.surahs[index].numberOfSurah
                                      .toArabic(),
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                            Text(
                              quranController.surahs[index].nameOfSurah,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
