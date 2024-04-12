import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/common/search_textfield.dart';
import 'package:islamic_app/text_themes.dart';

import '../search/search_view.dart';
import 'widgets/tab_widget.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabsTitles = [
      S.of(context).sorahs,
      S.of(context).juzs,
    ];
    final GeneralController generalController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.of(context).quran,
            style: TextThemes.quranTitleTextStyle,
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Scrollbar(
              thickness: 3,
              interactive: true,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => const SearchView(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: const SearchTextField(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          2,
                          (index) => TabWidget(
                            title: tabsTitles[index],
                            isSelected:
                                index == generalController.tabSelected.value,
                            onTap: () {
                              generalController.tabSelected.value = index;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SurasSliverList()
                  Constant.tabsViews[generalController.tabSelected.value],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
