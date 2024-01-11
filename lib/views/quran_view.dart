import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/views/about_us_view.dart';
import 'package:islamic_app/views/settings_view.dart';
import 'package:share_plus/share_plus.dart';

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
  late AdvancedDrawerController _advancedDrawerController;
  @override
  void initState() {
    _advancedDrawerController = AdvancedDrawerController();
    super.initState();
  }

  @override
  void dispose() {
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openRatio: 0.7,
      openScale: 0.9,
      rtlOpening: true,
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: CustomAppBar(
          advancedDrawerController: _advancedDrawerController,
        ),
        body: QuranViewBody(),
      ),
      drawer: Container(
        child: Column(
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
      ),
    );
  }
}
