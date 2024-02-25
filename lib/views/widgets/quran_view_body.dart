import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

import '../../generated/l10n.dart';
import 'all_sorah_list_view.dart';
import 'hijri_widget_info.dart';
import 'last_sorah_read_item.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  // int? currentTapIndex;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return Scrollbar(
      interactive: true,
      thickness: 6,
      controller: quranController.homePageScrollerController,
      radius: const Radius.circular(8),
      child: CustomScrollView(
        controller: quranController.homePageScrollerController,
        slivers: [
          const SliverToBoxAdapter(
            child: HijriWidgetInfo(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 4.h,
              ),
              child: Text(
                S.of(context).lastRead,
                style: TextStyle(
                  color: kThirdlyColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  fontFamily: kFontKufamRegular,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: LastSorahReadWidget(),
          ),
          const AllSorahListView(),
        ],
      ),
    );
  }
}
