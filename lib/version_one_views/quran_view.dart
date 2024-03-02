import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/bindings/bindings.dart';
import 'package:share_plus/share_plus.dart';

import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/version_one_views/about_us_view.dart';
import 'package:islamic_app/version_one_views/bookmark_view.dart';
import 'package:islamic_app/version_one_views/settings_view.dart';

import 'azkar_view.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/drawer_item.dart';
import 'widgets/quran_view_body.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});
  static const String id = "Quran-View";

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return AdvancedDrawer(
      openRatio: 0.7,
      openScale: 0.9,
      rtlOpening: true,
      controller: quranController.advancedDrawerController,
      drawer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 64.h),
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
          DrawerItem(
            title: "المفضلة",
            leadingIcon: Icons.favorite_outline_sharp,
            onTap: () {
              Get.to(const BookmarkView());
            },
          ),
          DrawerItem(
            title: "الأذكار",
            leadingIcon: Icons.add_task_sharp,
            onTap: () {
              // var azker = Get.put(AzkarController());
              // azker.getAllTheAzkar();
              Get.to(const AzkarView(), binding: InitialBindings());
            },
          ),
          DrawerItem(
            title: "الأعدادات",
            leadingIcon: Icons.settings,
            onTap: () {
              Navigator.pushNamed(context, SettingsView.id);
            },
          ),
          DrawerItem(
            title: "عنا",
            leadingIcon: Icons.info_outline,
            onTap: () {
              Navigator.pushNamed(context, AboutUsView.id);
            },
          ),
          DrawerItem(
            title: "شارك التطبيق",
            leadingIcon: Icons.share_outlined,
            onTap: () {
              Share.share(
                "يمكنك تحميل تطبيق نور المؤمن من هذه القناة أنه تطبيق رائع\nhttps://t.me/ayhamapp2",
                subject: "أشارك معك تطبيق نور المؤمن",
              );
            },
          ),
        ],
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          advancedDrawerController: quranController.advancedDrawerController,
        ),
        body: const QuranViewBody(),
        floatingActionButton: Container(
          color: Colors.red,
          child: GestureDetector(
            child: const Icon(Icons.arrow_upward_rounded),
            onTap: () {
              // bookMarkController.getAllAyasBookMarks();
              quranController.homePageScrollerController.animateTo(
                0,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeIn,
              );
              // bookMarkController.addAyaBookMark(1);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
