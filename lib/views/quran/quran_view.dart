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
            style: TextThemes.quranTitleTextStyle(context),
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => const SearchView(),
                        transition: Transition.fade,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: const SearchTextField(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TabBar(
                        tabs: List.generate(
                          tabsTitles.length,
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
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return Constant
                            .tabsViews[generalController.tabSelected.value];
                      },
                      itemCount: 2,
                      onPageChanged: (value) {
                        generalController.tabSelected.value = value;
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
