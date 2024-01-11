import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:settings_ui/settings_ui.dart';

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
    return Scaffold(
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
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text("العرض"),
            tiles: [
              SettingsTile(
                title: Text(
                  'حجم الخط',
                ),
                description: Column(
                  children: [
                    FutureBuilder(
                        future: settingsService.getStringValue("ayaFontSize"),
                        builder: (context, snapshot) {
                          double sliderValue =
                              double.parse(snapshot.data ?? "24");
                          return Column(
                            children: [
                              Slider(
                                  activeColor: kThirdlyColor,
                                  divisions: 8,
                                  min: 12,
                                  max: 32,
                                  value: sliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      sliderValue = value.roundToDouble();
                                      settingsService.saveStringValue(
                                        "ayaFontSize",
                                        value.round().toString(),
                                      );
                                    });
                                  }),
                              Text('${snapshot.data ?? 24}'),
                              Text(
                                "هذه الطريقة التي ستظهر بها الآيات",
                                style: TextStyle(
                                  fontSize:
                                      double.parse(snapshot.data ?? "24").sp,
                                  color: kThirdlyColor,
                                  fontFamily: kFontUthmanicHafs,
                                ),
                              ),
                            ],
                          );
                        }),
                    FutureBuilder(
                        future: settingsService.getStringValue("fontSize"),
                        builder: (context, snapshot) {
                          double sliderValue =
                              double.parse(snapshot.data ?? "16");
                          return Column(
                            children: [
                              Slider(
                                  activeColor: kThirdlyColor,
                                  divisions: 8,
                                  min: 12,
                                  max: 32,
                                  value: sliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      sliderValue = value.roundToDouble();
                                      settingsService.saveStringValue(
                                          "fontSize", value.round().toString());
                                    });
                                  }),
                              Text('${snapshot.data ?? "16"}'),
                              Text(
                                "هذه الطريقة التي سيظهر بها تفسير الآيات",
                                style: TextStyle(
                                  fontSize:
                                      double.parse(snapshot.data ?? "16").sp,
                                  color: kThirdlyColor,
                                  fontFamily: kFontKufamRegular,
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
