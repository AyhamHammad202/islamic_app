import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/views/widgets/prayer_reminder_settings.dart';

import 'widgets/custom_slider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String id = "Settings-View";

  // final SettingsServic2e s2ettingsService = SettingsServic2e();

  @override
  Widget build(BuildContext context) {
    final SettingsService settingsService = Get.find();
    final QuranController quranController = Get.find();
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
            GetX<SettingsService>(
              builder: (c) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingsSectionTitle("حجم الخط"),
                  CustomSlider(
                    settingKey: kSettingAyaFontSizeKey,
                    displayText:
                        "${quranController.surahs.first.ayas.first.text.characters.first} ${quranController.surahs.first.ayas.first.text.substring(1)}",
                    fontFamily: "page1",
                    fontSize: settingsService.ayaFontSize.value,
                    onChanged: (value) {
                      settingsService.setAyaFontSize(value.round());
                    },
                  ),
                  Divider(
                    indent: 15.h,
                    endIndent: 15.h,
                    color: kSecondlyColor,
                  ),
                  CustomSlider(
                    settingKey: kSettingAyaTafserFontSizeKey,
                    displayText: "هذه الطريقة التي سيظهر بها تفسير الآيات",
                    fontFamily: kFontKufamRegular,
                    fontSize: settingsService.ayaTafserFontSize.value,
                    onChanged: (value) {
                      settingsService.setAyaTafserFontSize(value.round());
                    },
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
            GetX<SettingsService>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSettingsSectionTitle(
                    "الأشعارات",
                  ),
                  PrayerReminder(
                    prayerName: "صلاة الضحى",
                    reminderText: "التذكير بصلاة الضحى",
                    settingsKey: kSettingSalatAldohaKey,
                    notificationId: 1,
                    channelKey: "salatAldoha",
                    isEnabled: settingsService.salatAldohaReminder.value,
                    updateValue: (isEnabled) {
                      settingsService.setSalatAldohaReminder(isEnabled);
                    },
                  ),
                  Divider(
                    indent: 15.h,
                    endIndent: 15.h,
                    color: kSecondlyColor,
                  ),
                  PrayerReminder(
                    prayerName: "صلاة الوتر",
                    reminderText: "التذكير بصلاة الوتر",
                    settingsKey: kSettingSalatAlotrKey,
                    notificationId: 2,
                    channelKey: "salatAlotr",
                    isEnabled: settingsService.salatAlotrReminder.value,
                    updateValue: (isEnabled) {
                      settingsService.setSalatAlotrReminder(isEnabled);
                    },
                  ),
                ],
              );
            })
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
