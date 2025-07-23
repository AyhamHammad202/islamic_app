import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:quran_library/quran.dart';

class BookmarkedAya extends StatelessWidget {
  const BookmarkedAya({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final BookMarkController bookMarkController = Get.find();
    Get.find();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookMarkController.ayasWithBookMark[index].text
                .replaceAll("\n", ""),
            style: TextThemes.bookmarkedAyaTextStyle(context),
          ),
          Gap(8.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  bookMarkController.deleteAyaBookMark(
                    bookMarkController.ayasWithBookMark[index].ayahUQNumber,
                  );
                },
                child: SvgPicturesMethods.bookmarkedIcon(
                  height: 20.h,
                ),
              ),
              Gap(8.w),
              Text(
                "${QuranLibrary().getCurrentSurahDataByAyah(ayah: bookMarkController.ayasWithBookMark[index]).arabicName} ${S.of(context).aya} ${bookMarkController.ayasWithBookMark[index].ayahNumber}",
                style: TextThemes.bookmarkedInfoTextStyle(context),
              )
            ],
          )
        ],
      ),
    );
  }
}
