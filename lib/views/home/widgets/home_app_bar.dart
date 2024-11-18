import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/search/search_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.hijri,
  });

  final HijriCalendar hijri;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Container(), // This will hide the end drawer hamburger icon
      ],
      title: Builder(builder: (context) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('السلام عليكم'),
                Row(
                  children: [
                    SvgPicturesMethods.calendarIcon(width: 15.w, height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        "${hijri.dayWeName}, ${hijri.hDay.toArabic()} ${hijri.longMonthName} ${hijri.hYear.toArabic()} هـ",
                        style: TextThemes.dateTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const SearchView(),
                    transition: Transition.upToDown,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: SvgPicturesMethods.searchIcon(height: 40.h),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
