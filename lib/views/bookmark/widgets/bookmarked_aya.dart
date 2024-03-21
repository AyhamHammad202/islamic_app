import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/svg_pictures.dart';

class BookmarkedAya extends StatelessWidget {
  const BookmarkedAya({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final BookMarkController bookMarkController = Get.find();
    final QuranController quranController = Get.find();
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
            bookMarkController.ayasWithBookMark[index].textOfAya
                .replaceAll("\n", ""),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Gap(8.h),
          Row(
            children: [
              InkWell(
                onTap: () {
                  bookMarkController.deleteAyaBookMark(
                    bookMarkController.ayasWithBookMark[index].uniqueIdOfAya,
                  );
                },
                child: SvgPicturesMethods.bookmarkedIcon(
                  height: 20.h,
                ),
              ),
              Gap(8.w),
              Text(
                "${quranController.surahs[quranController.getSurahNumberByAya(bookMarkController.ayasWithBookMark[index]) - 1].nameOfSurah} ${S.of(context).aya} ${bookMarkController.ayasWithBookMark[index].numberOfAyaInSurah}",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 12.sp,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
