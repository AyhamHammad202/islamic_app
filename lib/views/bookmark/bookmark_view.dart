import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../ayat/ayat_view.dart';
import 'widgets/bookmarked_aya.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final BookMarkController bookMarkController = Get.find();
    return BackgroundImage(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              S.of(context).bookmarkAyat,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AnimationLimiter(
              child: GetBuilder<BookMarkController>(
                builder: (c) => ListView.builder(
                  itemCount: bookMarkController.ayasWithBookMark.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: FadeInAnimation(
                        duration: Durations.medium2,
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: InkWell(
                            onTap: () {
                              quranController.globalPage.value =
                                  bookMarkController
                                          .ayasWithBookMark[index].page -
                                      1;
                              quranController.getCurrentPageAyas(
                                  bookMarkController
                                          .ayasWithBookMark[index].page -
                                      1);
                              quranController.selectedAyahIndexes.add(
                                  bookMarkController
                                      .ayasWithBookMark[index].uniqueIdOfAya);
                              Get.to(
                                AyatView(
                                  surahModel: quranController.surahs[
                                      quranController.getSurahNumberByAya(
                                              bookMarkController
                                                  .ayasWithBookMark[index]) -
                                          1],
                                ),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: BookmarkedAya(
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
    );
  }
}
