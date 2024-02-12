import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/views/widgets/tafser_richtext_widget.dart';

class TafserBottomSheet extends StatelessWidget {
  const TafserBottomSheet({
    super.key,
    required this.tafser,
    required this.ayaOfSurahModel,
    required this.page,
    required this.numberOfSura,
  });

  final String tafser;
  final AyaOfSurahModel ayaOfSurahModel;
  final int page;
  final int numberOfSura;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "${quranController.surahs[numberOfSura - 1].nameOfSurah}",
                    style: TextStyle(
                      fontFamily: kFontKufamRegular,
                    ),
                  ),
                  Text(
                      "الآية:" + ayaOfSurahModel.numberOfAyaInSurah.toArabic()),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: kFontUthmanicHafs,
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                  children: [
                    TextSpan(
                      text: ayaOfSurahModel.textOfAya,
                    ),
                    TextSpan(
                      text: " ${ayaOfSurahModel.text.characters.last}",
                      style: TextStyle(
                        fontFamily: "page${page + 1}",
                        color: Colors.indigo,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TafserRichTextWidget(text: tafser, fontSize: "16"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
