import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:quran_library/quran.dart';

class DownloadingDialog extends StatelessWidget {
  const DownloadingDialog({
    super.key,
    required this.readersController,
    required this.surahModel,
  });

  final ReadersController readersController;
  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, r) {
        if (didPop) {
          readersController.cancelToken
              .cancel("User exist from downloading page");
        }
      },
      child: Obx(() {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "${S.current.download} ${Get.locale?.languageCode == 'ar' ? surahModel.arabicName : surahModel.englishName}",
            style: TextThemes.suraNameTextStyle(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                  value: (readersController.downloadedAyatCount.value /
                      surahModel.ayahs.length)),
              const SizedBox(height: 10),
              Text(
                "${S.current.download}: ${(readersController.downloadedAyatCount.value / surahModel.ayahs.length * 100).toInt()}%",
                style: TextThemes.downloadInfoTextStyle(context),
              ),
              Text(
                S.current.downloaded(
                  readersController.downloadedAyatCount.value,
                  surahModel.ayahs.length,
                ),
                style: TextThemes.downloadInfoTextStyle(context),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Close the dialog
                readersController.cancelToken
                    .cancel("User exist from downloading page");
                Get.back();
              },
              child: Text(
                S.current.close,
                style: TextThemes.closeTextStyle(context),
              ),
            ),
          ],
        );
      }),
    );
  }
}
