import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';

class CustomSlider extends StatelessWidget {
  final String settingKey;
  final String displayText;
  final String fontFamily;
  final int fontSize;
  final void Function(double)? onChanged;

  const CustomSlider({
    super.key,
    required this.settingKey,
    required this.displayText,
    required this.fontFamily,
    required this.fontSize,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          activeColor: kThirdlyColor,
          divisions: 8,
          min: 12,
          max: 32,
          value: fontSize.toDouble(),
          onChanged: onChanged,
        ),
        Text(fontSize.toString()),
        Text(
          displayText,
          style: TextStyle(
            fontSize: double.parse(fontSize.toString()).sp,
            color: kThirdlyColor,
            fontFamily: fontFamily,
          ),
        ),
      ],
    );
  }
}
