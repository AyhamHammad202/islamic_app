import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/text_themes.dart';

import 'widgets/downloading_dialog.dart';

class SuraDownloadView extends StatelessWidget {
  const SuraDownloadView({super.key, required this.readerModel});
  final ReaderModel readerModel;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    ReadersController readersController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.current.downloadAyat,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            itemCount: quranController.surahs.length,
            itemBuilder: (context, index) {
              SurahModel surahModel = quranController.surahs[index];
              return Obx(() {
                readersController.checkIfSuraDownloaded(
                    surahModel, readerModel);
                String key =
                    '${surahModel.englishNameOfSurah}-${readerModel.englishName}';
                bool isSuraDownloaded =
                    readersController.suraDownloadStatus[key] ?? false;
                return InkWell(
                  onTap: () async {
                    if (!isSuraDownloaded) {
                      Get.dialog(
                        barrierDismissible: false,
                        DownloadingDialog(readersController: readersController, surahModel: surahModel),
                      );
                      await readersController.downloadSuraAyas(
                        surahModel,
                        readerModel,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          surahModel.nameOfSurah,
                          style: TextThemes.suraNameTextStyle(context),
                        ),
                        Text(
                          isSuraDownloaded
                              ? "تم تحميل السورة"
                              : "لم يتم تحميل السورة",
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
