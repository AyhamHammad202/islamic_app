import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/views/ayat/widgets/bassmlah.dart';
import 'package:islamic_app/views/ayat/widgets/sura_bannar_with_name.dart';

import 'widgets/ayat_of_page.dart';

class AyatView extends StatelessWidget {
  const AyatView({super.key, required this.surahModel});
  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final LastReadService lastReadService = Get.find();
    quranController.pageController =
        PageController(initialPage: quranController.globalPage.value);
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) {
          quranController.selectedAyahIndexes.clear();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: GetX<QuranController>(builder: (controller) {
              return Text(
                quranController
                    .surahs[quranController.getSurahNumberByAya(quranController
                            .pages[quranController.globalPage.value].first) -
                        1]
                    .nameOfSurah,
              );
            }),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: PageView.builder(
                controller: quranController.pageController,
                itemCount: 604,
                onPageChanged: (page) {
                  lastReadService.setLastRead(
                    page + 1,
                    "${DateTime.now()}",
                    quranController
                        .getSurahNumberByAya(quranController.pages[page].first),
                    quranController.pages[page].first.numberOfAyaInSurah,
                  );
                  quranController.globalPage.value = page;
                },
                itemBuilder: (context, page) {
                  quranController.getCurrentPageAyahsSeparatedForBasmala(page);
                  return SingleChildScrollView(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      radius: 0,
                      onTap: () {
                        quranController.clearSelection();
                      },
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                              quranController
                                  .getCurrentPageAyahsSeparatedForBasmala(page)
                                  .length,
                              (index) {
                                final ayas = quranController
                                    .getCurrentPageAyahsSeparatedForBasmala(
                                        page)[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // quranController.getCurrentPageAyahsSeparatedForBasmala(pageIndex)[i];
                                    ayas.first.numberOfAyaInSurah == 1 &&
                                            !Constant.lastPlaceBannerPageIndex
                                                .contains(page)
                                        ? SuraBannerWithName(
                                            aya: ayas.first,
                                            quranController: quranController,
                                          )
                                        : const SizedBox.shrink(),
                                    ayas.first.numberOfAyaInSurah == 1
                                        ? Bassmalah(
                                            aya: ayas.first,
                                            quranController: quranController,
                                          )
                                        : const SizedBox.shrink(),
                                    AyatOfPage(
                                      ayas: ayas,
                                      quranController: quranController,
                                      page: page,
                                    ),
                                    LastBannar(
                                        aya: ayas.last,
                                        quranController: quranController),
                                  ],
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${S.of(context).juz} ${quranController.pages[page].last.juz}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                    ),
                              ),
                              Text(
                                (page + 1).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              Text(
                                "${S.of(context).hizb} ${(quranController.pages[page].last.hizbQuarter / 4).ceil()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef LongPressStartDetailsFunction = void Function(LongPressStartDetails);
