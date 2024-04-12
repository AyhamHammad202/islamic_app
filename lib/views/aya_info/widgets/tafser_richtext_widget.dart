import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/text_themes.dart';

class TafserRichTextWidget extends StatelessWidget {
  final String text;
  final int fontSize;

  const TafserRichTextWidget(
      {super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'\{[^}]+\}');
    String remaining = text;

    List<TextSpan> textSpans = [];

    while (regex.hasMatch(remaining)) {
      final match = regex.firstMatch(remaining)!;
      final matchedString = match.group(0)!;
      final leadingText = remaining.substring(0, match.start);

      if (leadingText.isNotEmpty) {
        textSpans.add(
          TextSpan(
            text: leadingText,
            style: TextThemes.tafserTextStyle.copyWith(
              fontSize: fontSize.sp,
            ),
          ),
        );
      }

      final strippedWord = matchedString.replaceAll(RegExp(r'[{}]'), '');
      textSpans.add(
        TextSpan(
          text: strippedWord,
          style: TextThemes.ayaInTafserTextStyle.copyWith(
            fontSize: fontSize.sp,
          ),
        ),
      );

      remaining = remaining.substring(match.end);
    }

    if (remaining.isNotEmpty) {
      textSpans.add(
        TextSpan(
          text: remaining,
          // style: TextStyle(color: Colors.black),
        ),
      );
    }

    return SelectableText.rich(
      TextSpan(
        style: TextStyle(
          fontFamily:
              kFontNotoNaskhArabic, // Replace with another font if needed
          color: Colors.black,
          fontSize: fontSize.sp,
        ),
        children: textSpans,
      ),
      textAlign: TextAlign.justify,
      selectionHeightStyle: BoxHeightStyle.strut,
    );
  }
}
