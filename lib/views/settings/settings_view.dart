import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/services/theme_services.dart';
import 'package:islamic_app/text_themes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsService settingsService = Get.find();
    ThemeController themeController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.settings),
        ),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) async {
                      themeController.switchThemeMode();
                    },
                    hoverColor: Colors.red,
                    activeColor: Colors.amber,
                    title: Text(
                      S.current.darkTheme,
                      style: TextThemes.settingTextStyle(context),
                    ),
                  ),
                  const Divider(),
                  Gap(8.h),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.current.tafserFontSize,
                            style: TextThemes.settingTextStyle(context),
                          ),
                          Gap(32.w),
                          Text(
                            settingsService.ayaTafserFontSize.toString(),
                            style: TextThemes.settingTextStyle(context),
                          )
                        ],
                      ),
                      Slider(
                        value:
                            settingsService.ayaTafserFontSize.value.toDouble(),
                        max: 32,
                        min: 4,
                        divisions: 6,
                        onChanged: (value) {
                          settingsService.setAyaTafserFontSize(
                            value.toInt(),
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.current.ayaFontSize,
                            style: TextThemes.settingTextStyle(context),
                          ),
                          Gap(32.w),
                          Text(
                            settingsService.ayaFontSize.toString(),
                            style: TextThemes.settingTextStyle(context),
                          )
                        ],
                      ),
                      Slider(
                        value: settingsService.ayaFontSize.value.toDouble(),
                        max: 32,
                        min: 8,
                        divisions: 8,
                        onChanged: (value) {
                          settingsService.setAyaFontSize(
                            value.toInt(),
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
