import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/views/surah_info/widgets/info_widget.dart';

class SurahInfoView extends StatelessWidget {
  const SurahInfoView({super.key, required this.surahModel});
  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return BackgroundImage(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "${S.of(context).suraInfo} ${quranController.suarhsInfo[surahModel.numberOfSurah - 1].suraName}",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InfoWidget(
                  title: "أسمائها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].itsNames,
                ),
                InfoWidget(
                  title: "عدد آياتها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].ayat,
                ),
                InfoWidget(
                  title: "معاني أسمائها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].itsNameMeaning,
                ),
                InfoWidget(
                  title: "سبب تسميتها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].reasonOfName,
                ),
                InfoWidget(
                  title: "سبب نزولها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].reasonOfNuzolha,
                ),
                InfoWidget(
                  title: "مناسباتها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].munasaba
                      .join(),
                ),
                InfoWidget(
                  title: "فضلها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].fadluha
                      .join(),
                ),
                InfoWidget(
                  title: "مقصدها",
                  info: quranController
                      .suarhsInfo[surahModel.numberOfSurah - 1].maqsad,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
