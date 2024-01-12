
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/services/settings_service.dart';

class CustomSlider extends StatefulWidget {
  final String settingKey;
  final String displayText;
  final String fontFamily;
  final SettingsService settingsService;

  CustomSlider({
    required this.settingKey,
    required this.displayText,
    required this.fontFamily,
    required this.settingsService,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.settingsService.getStringValue(widget.settingKey),
      builder: (context, snapshot) {
        double sliderValue = double.parse(snapshot.data ?? "24");
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
                  widget.settingsService.saveStringValue(
                    widget.settingKey,
                    value.round().toString(),
                  );
                });
              },
            ),
            Text('${snapshot.data ?? "24"}'),
            Text(
              widget.displayText,
              style: TextStyle(
                fontSize: double.parse(snapshot.data ?? "24").sp,
                color: kThirdlyColor,
                fontFamily: widget.fontFamily,
              ),
            ),
          ],
        );
      },
    );
  }
}
