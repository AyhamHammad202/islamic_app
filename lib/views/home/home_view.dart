import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/views/home/widgets/last_read_aya.dart';
import 'package:islamic_app/views/search/search_view.dart';

import '../../constants/constant.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    var hijri = HijriCalendar.now();
    QuranController quranController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: Drawer(
          // ignore: use_full_hex_values_for_flutter_colors
          backgroundColor: const Color(0xfff043336),
          shadowColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(kAppIconAsset),
                ),
                Text(
                  "نور المؤمن",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: kFontKufamRegular,
                    color: kThirdlyColor,
                  ),
                ),
                ListTile(
                  leading: SvgPicturesMethods.bookmarkIcon(),
                  title: Text(
                    "المفضلة",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {
                    Get.showSnackbar(const GetSnackBar(
                      message: "ستتوفر قريبا",
                      duration: Durations.extralong4,
                    ));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text(
                    "الأعدادات",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {
                    Get.showSnackbar(const GetSnackBar(
                      message: "ستتوفر قريبا",
                      duration: Durations.extralong4,
                    ));
                  },
                ),
                Column(
                  children: List.generate(
                    quranController.tables.length,
                    (index) => Text(
                      quranController.tables[index],
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Container(), // This will hide the end drawer hamburger icon
          ],
          title: Builder(builder: (context) {
            return Row(
              children: [
                SvgPicturesMethods.calendarIcon(),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    "${hijri.dayWeName}, ${hijri.hDay.toArabic()} ${hijri.longMonthName} ${hijri.hYear.toArabic()} هـ",
                  ),
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
                    child: SvgPicturesMethods.searchIcon(height: 15.h),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: SvgPicturesMethods.menuIcon(height: 10.h),
                  ),
                ),
              ],
            );
          }),
        ),
        body: GetBuilder<BookMarkController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LastReadAya(),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: Constant.homeSections.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) =>
                        Constant.homeSections[index],
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
