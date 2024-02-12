import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/menu_extension.dart';
import 'package:islamic_app/models/surah_model.dart';

class AyatImagePageView extends StatelessWidget {
  const AyatImagePageView({
    super.key,
    required this.sorahModel,
    required this.pageController,
  });
  final SurahModel sorahModel;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PageView.builder(
        controller: pageController,
        itemCount: 604,
        itemBuilder: (context, page) {
          quranController.getCurrentPageAyahsSeparatedForBasmala(page);
          quranController.GetAyaTafser(page + 1);
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
              child: SizedBox(
                // height: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      quranController
                          .getCurrentPageAyahsSeparatedForBasmala(page)
                          .length, (i) {
                    final ayas = quranController
                        .getCurrentPageAyahsSeparatedForBasmala(page)[i];
                    return Column(
                      children: [
                        ayas[0].numberOfAyaInSurah == 1
                            ? Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/design/Sorah_name_ba3.svg"),
                                      SvgPicture.asset(
                                          "assets/images/sorahs/${quranController.getSurahNumberByAya(ayas.first).toString().padLeft(3, '0')}.svg"),
                                    ],
                                  ),
                                  quranController.getSurahNumberByAya(
                                                  ayas.first) ==
                                              9 ||
                                          quranController.getSurahNumberByAya(
                                                  ayas.first) ==
                                              1
                                      ? SizedBox.shrink()
                                      : SvgPicture.asset(
                                          quranController.getSurahNumberByAya(
                                                          ayas.first) ==
                                                      95 ||
                                                  quranController
                                                          .getSurahNumberByAya(
                                                              ayas.first) ==
                                                      97
                                              ? "assets/images/design/besmAllah2.svg"
                                              : "assets/images/design/besmAllah.svg",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                        )
                                ],
                              )
                            : SizedBox.shrink(),
                        Obx(
                          () => RichText(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'page${page + 1}',
                                fontSize: getProportionateScreenWidth(22),
                                letterSpacing: .01,
                                wordSpacing: .01,
                                height: 1.9,
                                color: Colors.black,
                              ),
                              children: List.generate(
                                ayas.length,
                                (index) {
                                  quranController.isSelected = quranController
                                      .selectedAyahIndexes
                                      .contains(ayas[index].uniqueIdOfAya);
                                  return TextSpan(
                                    text: index == 0
                                        ? "${ayas[index].text[0]} ${ayas[index].text.substring(1)}"
                                        : ayas[index].text,
                                    style: TextStyle(
                                        backgroundColor:
                                            quranController.isSelected
                                                ? Colors.lightBlue.shade300
                                                    .withOpacity(0.3)
                                                : null),
                                    recognizer: LongPressGestureRecognizer(
                                        duration: Durations.long2)
                                      ..onLongPressStart =
                                          (LongPressStartDetails details) {
                                        quranController.toggleAyahSelection(
                                            ayas[index].uniqueIdOfAya);
                                        context.showAyahMenu(
                                            quranController
                                                .getSurahNumberFromPage(page),
                                            page,
                                            quranController
                                                .getSurahNameFromPage(page),
                                            index,
                                            details: details,
                                            ayaOfSurahModel: ayas[index]);
                                      },
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
