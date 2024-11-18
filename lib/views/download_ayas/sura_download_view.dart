import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/svg_pictures.dart';
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
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.secondary.withOpacity(.4),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Gap(6.w),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicturesMethods.frameIcon(
                            height: 30.h,
                          ),
                          Text(
                            surahModel.numberOfSurah.toArabic(),
                            style: TextThemes.suraNumTextStyle(context),
                          )
                        ],
                      ),
                      Gap(4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surahModel.nameOfSurah.substring(8),
                            style: TextThemes.suraNameTextStyle(context)
                                .copyWith(fontSize: 16.sp),
                          ),
                          Text(
                            "${surahModel.ayas.length.toArabic()} ${S.current.aya}",
                            style: TextThemes.suraInfoTextStyle(context),
                          ),
                        ],
                      ),
                      const Spacer(),
                      isSuraDownloaded
                          ? SvgPicturesMethods.downloadedIcon(
                              height: 20.h,
                            )
                          : InkWell(
                              onTap: () async {
                                if (!isSuraDownloaded) {
                                  Get.dialog(
                                    barrierDismissible: false,
                                    DownloadingDialog(
                                        readersController: readersController,
                                        surahModel: surahModel),
                                  );
                                  await readersController.downloadSuraAyas(
                                    surahModel,
                                    readerModel,
                                  );
                                }
                              },
                              child: SvgPicturesMethods.downloadIcon(
                                height: 20.h,
                              ),
                            ),
                      Gap(6.w)
                    ],
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
