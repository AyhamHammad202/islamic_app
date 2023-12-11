import 'package:flutter/material.dart';
import 'package:islamic_app/generated/l10n.dart';

import 'tab_bar_item.dart';

class TabBarHomeView extends StatefulWidget {
  const TabBarHomeView({
    super.key,
  });

  @override
  State<TabBarHomeView> createState() => _TabBarHomeViewState();
}

class _TabBarHomeViewState extends State<TabBarHomeView> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    List tabs = [
      S.of(context).sura,
      S.of(context).page,
      S.of(context).juz,
      S.of(context).hizb,
      S.of(context).ruku,
    ];
    return Container(
      padding: EdgeInsetsDirectional.only(end: 4, start: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff795547),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 45,
        child: ListView.builder(
            itemCount: tabs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      current = index;
                    },
                  );
                },
                child: TabBarItem(
                  title: tabs[index],
                  isSelected: current == index,
                ),
              );
            }),
      ),
    );
  }
}
