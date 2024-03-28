import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/views/allah_names/allah_names_view.dart';
import 'package:islamic_app/views/bookmark/bookmark_view.dart';
import 'package:islamic_app/views/home/widgets/last_read_aya.dart';
import 'package:islamic_app/views/quran/quran_view.dart';
import 'package:islamic_app/views/radio/quran_radio_view.dart';
import 'package:islamic_app/views/search/search_view.dart';
import 'package:islamic_app/views/tasbeh/tasbeh_view.dart';

import '../../constants/constant.dart';
import '../year_occasion/year_occasion_view.dart';
import 'widgets/section_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    var hijri = HijriCalendar.now();
    QuranController quranController = Get.find();
    final BookMarkController bookMarkController = Get.find();
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
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      SectionWidget(
                        title: S.of(context).quran,
                        svgIcon: SvgPicturesMethods.quranBookIcon(
                          height: 75,
                          width: 75,
                        ),
                        onTap: () {
                          Get.put(() => GeneralController());
                          Get.to(
                            () => const QuranView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SectionWidget(
                        title: S.of(context).bookmarkAyat,
                        svgIcon: bookMarkController.bookmarkedAyasID.isEmpty
                            ? SvgPicturesMethods.bookmarkIcon(
                                height: 75,
                                width: 75,
                              )
                            : SvgPicturesMethods.bookmarkedIcon(
                                height: 75,
                                width: 75,
                              ),
                        onTap: () {
                          // Get.put(() => GeneralController());
                          Get.to(
                            () => const BookmarkView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SectionWidget(
                        title: S.of(context).allahNames,
                        svgIcon: SvgPicturesMethods.allahNamesIcon(
                          height: 75,
                          width: 75,
                        ),
                        onTap: () {
                          Get.to(
                            () => const AllahNamesView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SectionWidget(
                        title: S.of(context).tasbeh,
                        svgIcon: SvgPicturesMethods.tasbeehIcon(
                          height: 75,
                          width: 75,
                        ),
                        onTap: () {
                          Get.to(
                            () => const TasbehView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SectionWidget(
                        title: S.of(context).islamicOccasions,
                        svgIcon: SvgPicturesMethods.occasionsIcon(),
                        onTap: () {
                          Get.to(
                            () => const YearOccasionView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      SectionWidget(
                        title: S.of(context).radio,
                        svgIcon: SvgPicturesMethods.radioIcon(),
                        onTap: () {
                          Get.to(
                            () => const QuranRadioView(),
                            transition: Transition.rightToLeftWithFade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ],
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
