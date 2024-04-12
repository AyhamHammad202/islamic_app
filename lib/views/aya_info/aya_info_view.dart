// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';

import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:share_plus/share_plus.dart';

import 'widgets/tafser_richtext_widget.dart';

class AyaInfoView extends StatelessWidget {
  const AyaInfoView({
    super.key,
    required this.aya,
  });
  final AyaOfSurahModel aya;
  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
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
                      "${quranController.surahs[quranController.getSurahNumberByAya(aya) - 1].nameOfSurah}  ${S.of(context).aya} ${aya.numberOfAyaInSurah}",
                      style: TextThemes.ayaInfoTextStyle,
                    ),
                    Gap(16.w),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(
                                text:
                                    '﴿${aya.textOfAya}﴾ [${quranController.surahs[quranController.getSurahNumberByAya(aya) - 1].nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}]',
                              ),
                            );
                          },
                          child: SvgPicturesMethods.copyIcon(),
                        ),
                        Gap(8.w),
                        InkWell(
                          onTap: () async {
                            Share.share(
                              '﴿${aya.textOfAya}﴾ [${quranController.surahs[quranController.getSurahNumberByAya(aya) - 1].nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}]',
                            );
                          },
                          child: SvgPicturesMethods.shareIcon(),
                        ),
                        Gap(8.w),
                        InkWell(
                          child: SvgPicturesMethods.bookmarkIcon(),
                        ),
                        Gap(8.w),
                      ],
                    ),
                  ],
                ),
                Gap(16.h),
                Text(
                  aya.text.replaceAll("\n", ""),
                  style: TextThemes.ayaTxtTextStyle.copyWith(
                    fontFamily: "page${aya.page}",
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                TafserRichTextWidget(
                  text: quranController.mapOfTafser[aya.uniqueIdOfAya]!,
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
