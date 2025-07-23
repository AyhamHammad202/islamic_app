// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/share_model_sheet.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/services/settings_service.dart';

import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/aya_info/widgets/tafser_richtext_widget.dart';
import 'package:quran_library/quran.dart';

class AyaInfoView extends StatelessWidget {
  const AyaInfoView({
    super.key,
    required this.aya,
    required this.surahModel,
  });
  final AyahModel aya;
  final SurahModel surahModel;
  @override
  Widget build(BuildContext context) {
    // final QuranController quranController = Get.find();
    final BookMarkController bookMarkController = Get.find();
    final SettingsService settingsService = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${surahModel.arabicName} ${S.of(context).aya} ${aya.ayahNumber}",
                      style: TextThemes.ayaInfoTextStyle(context),
                    ),
                    Gap(16.w),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(
                                text:
                                    '﴿${aya.ayaTextEmlaey}﴾ [${surahModel.arabicName}-${aya.ayahNumber.toArabic()}]',
                              ),
                            );
                            if (context.mounted) {
                              show(context: context, message: "تم النسخ");
                            }
                          },
                          child: SvgPicturesMethods.copyIcon(),
                        ),
                        Gap(8.w),
                        InkWell(
                          onTap: () async {
                            ShareModelSheet(
                              aya: aya,
                              surah: surahModel,
                            );
                          },
                          child: SvgPicturesMethods.shareIcon(),
                        ),
                        Gap(8.w),
                        InkWell(
                          child: SvgPicturesMethods.bookmarkIcon(),
                          onTap: () async {
                            await bookMarkController
                                .addAyaBookMark(aya.ayahUQNumber);
                          },
                        ),
                        Gap(8.w),
                      ],
                    ),
                  ],
                ),
                Gap(16.h),
                Text(
                  aya.text.replaceAll("\n", ""),
                  style: TextThemes.ayaTxtTextStyle(context).copyWith(
                    fontFamily: "page${aya.page}",
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                TafserRichTextWidget(
                  text: QuranLibrary()
                      .tafsirList
                      .firstWhere(
                        (element) => element.id == aya.ayahUQNumber,
                      )
                      .tafsirText,
                  fontSize: settingsService.ayaTafserFontSize.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
