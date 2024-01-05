import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';

import '../../generated/l10n.dart';
import 'all_sorah_list_view.dart';
import 'hijri_widget_info.dart';
import 'last_sorah_read_item.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  // int? currentTapIndex;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HijriWidgetInfo(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
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
        SliverToBoxAdapter(
          child: LastSorahReadWidget(),
        ),
        AllSorahListView(),
      ],
    );
  }
}
