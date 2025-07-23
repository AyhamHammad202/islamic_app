import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/common/search_textfield.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/search/widgets/ayas_search_sliverlist.dart';
import 'package:lottie/lottie.dart';

import 'widgets/suras_found_by_search.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    final GeneralController generalController = Get.find();
    return BackgroundImage(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, r) {
          if (didPop) {
            quranController.searchedAyas.clear();
            quranController.searchedSurahs.clear();
            generalController.searchController.clear();
            generalController.searchText.value = '';
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: GetBuilder<QuranController>(builder: (c) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SearchTextField(
                      isEnabled: true,
                      onChanged: (value) {
                        generalController.searchText.value = value;
                        quranController.search(value);
                        // quranController.searchForAyas(
                        //   value.trim(),
                        // );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: quranController.searchedSurahs.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              "${S.of(context).sorahs} ${quranController.searchedSurahs.length}",
                              style: TextThemes.searchResultsTextStyle(context),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SliverToBoxAdapter(
                    child: SurasFoundBySearch(quranController: quranController),
                  ),
                  SliverToBoxAdapter(
                    child: quranController.searchedAyas.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              "${S.of(context).theAyas} ${quranController.searchedAyas.length}",
                              style: TextThemes.searchResultsTextStyle(context),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const AyasSearchSliverList(),
                  if (quranController.searchedAyas.isEmpty &&
                      quranController.searchedSurahs.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        heightFactor: 1.7,
                        child: Lottie.asset(
                          Constant.searchLottie,
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
