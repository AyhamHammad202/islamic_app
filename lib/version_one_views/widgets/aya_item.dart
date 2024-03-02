import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:islamic_app/services/settings_service.dart';

import '../../models/aya_of_surah_model.dart';
import 'aya_item_above.dart';

class AyaItem extends StatelessWidget {
  const AyaItem({
    super.key,
    required this.aya,
    required this.numOfAyaInPage,
  });

  final AyaOfSurahModel aya;
  final int numOfAyaInPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AyaItemAbove(
            aya: aya,
            indexOfAyaInPage: numOfAyaInPage,
          ),
          GetX<SettingsService>(
            builder: (controller) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                numOfAyaInPage == 0
                    ? "${aya.text.characters.first} ${aya.text.substring(1).replaceAll("\n", "")}"
                    : aya.text.replaceAll("\n", ""),
                style: TextStyle(
                  fontFamily: "page${aya.page}",
                  color: Colors.black,
                  fontSize:
                      double.parse(controller.ayaFontSize.value.toString()).sp,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 20.w,
                    color: const Color(0xffC39B7B),
                    thickness: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
