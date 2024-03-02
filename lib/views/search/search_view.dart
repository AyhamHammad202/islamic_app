import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/common/search_textfield.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/search/widgets/ayas_search_sliverlist.dart';

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
        onPopInvoked: (didPop) {
          if (didPop) {
            quranController.ayasFoundBySearch.clear();
            quranController.surasFoundbySearch.clear();
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
                        quranController.searchForAyas(
                          value.trim(),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: quranController.surasFoundbySearch.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              "${S.of(context).sorahs} ${quranController.surasFoundbySearch.length}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 20.sp,
                                  ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SliverToBoxAdapter(
                    child: SurasFoundBySearch(quranController: quranController),
                  ),
                  SliverToBoxAdapter(
                    child: quranController.ayasFoundBySearch.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              "${S.of(context).theAyas} ${quranController.ayasFoundBySearch.length}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 20.sp,
                                  ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const AyasSearchSliverList(),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
