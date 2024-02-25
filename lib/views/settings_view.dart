import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/views/widgets/prayer_reminder_settings.dart';

import 'widgets/custom_slider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  static const String id = "Settings-View";

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsService settingsService = SettingsService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الأعدادات',
            style: TextStyle(
              fontFamily: kFontKufamRegular,
              color: kThirdlyColor,
              fontSize: 16.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingsSectionTitle("حجم الخط"),
                  CustomSlider(
                    settingKey: "ayaFontSize",
                    displayText: "هذه الطريقة التي ستظهر بها الآيات",
                    fontFamily: kFontUthmanicHafs,
                    settingsService: settingsService,
                  ),
                  Divider(
                    indent: 15.h,
                    endIndent: 15.h,
                    color: kSecondlyColor,
                  ),
                  CustomSlider(
                    settingKey: "fontSize",
                    displayText: "هذه الطريقة التي سيظهر بها تفسير الآيات",
                    fontFamily: kFontKufamRegular,
                    settingsService: settingsService,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Divider(
              indent: 3.h,
              endIndent: 3.h,
              color: Colors.black,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingsSectionTitle(
                    "الأشعارات",
                  ),
                  PrayerReminder(
                    prayerName: "صلاة الوتر",
                    reminderText: "التذكير بصلاة الوتر",
                    settingsKey: "salatAlotr",
                    notificationId: 2,
                    channelKey: "salatAlotr",
                    settingsService: settingsService,
                  ),
                  Divider(
                    indent: 15.h,
                    endIndent: 15.h,
                    color: kSecondlyColor,
                  ),
                  PrayerReminder(
                    prayerName: "صلاة الضحى",
                    reminderText: "التذكير بصلاة الضحى",
                    settingsKey: "salatAldoha",
                    notificationId: 1,
                    channelKey: "salatAldoha",
                    settingsService: settingsService,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildSettingsSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.blue,
          fontFamily: kFontKufamRegular,
        ),
      ),
    );
  }
}
