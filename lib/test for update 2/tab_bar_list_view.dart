import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';

import '../generated/l10n.dart';
import 'tab_bar_item.dart';

class TabBarListView extends StatefulWidget {
  const TabBarListView({
    super.key,
  });

  @override
  State<TabBarListView> createState() => _TabBarListViewState();
}

class _TabBarListViewState extends State<TabBarListView> {
  int? tap;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      S.of(context).sorahs,
      S.of(context).pages,
      S.of(context).juz,
      S.of(context).qurter,
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          color: kThirdlyColor, borderRadius: BorderRadius.circular(8.r)),
      child: SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: tabs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tap = index;
                });
              },
              child: TabBarItem(
                title: tabs[index],
                isSelected: tap == index,
              ),
            );
          },
        ),
      ),
    );
  }
}
