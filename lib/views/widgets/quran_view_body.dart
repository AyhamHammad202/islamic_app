import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/cubits/tabs/tabs_cubit.dart';

import '../../generated/l10n.dart';
import 'all_juzes_list_view.dart';
import 'all_sorah_list_view.dart';
import 'hijri_widget_info.dart';
import 'last_sorah_read_item.dart';
import 'tab_bar_list_view.dart';

class QuranViewBody extends StatefulWidget {
  const QuranViewBody({super.key});

  @override
  State<QuranViewBody> createState() => _QuranViewBodyState();
}

class _QuranViewBodyState extends State<QuranViewBody> {
  int? currentTapIndex;
  @override
  void initState() {
    // currentTapIndex = BlocProvider.of<QuranCubit>(context).currentTapIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabsCubit(),
      child: CustomScrollView(
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
          SliverToBoxAdapter(
            child: TabBarListView(),
          ),
          BlocBuilder<TabsCubit, TabsState>(
            builder: (context, state) {
              if (state is TabsChanged) {
                switch (state.index) {
                  case 0:
                    return AllSorahListView();
                  case 2:
                    return AllJuzesListView();
                  default:
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.index.toString())),
                    );
                }
              }
              return AllSorahListView();
            },
          )
        ],
      ),
    );
  }
}
