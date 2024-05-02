
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/text_themes.dart';

class PageInfo extends StatelessWidget {
  const PageInfo({
    super.key,
    required this.page,
  });

  final int page;

  @override
  Widget build(BuildContext context) {
  QuranController quranController=Get.find();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "${S.of(context).juz} ${quranController.pages[page].last.juz}",
          style:TextThemes.pageInfoTextStyle(context),
        ),
        Gap(16.w),
        Text(
          (page + 1).toString(),
          style: TextThemes.pageNumTextStyle(context)
        ),
        Gap(16.w),
        Text(
          "${S.of(context).hizb} ${(quranController.pages[page].last.hizbQuarter / 4).ceil()}",
          style: TextThemes.pageInfoTextStyle(context),
        ),
      ],
    );
  }
}
