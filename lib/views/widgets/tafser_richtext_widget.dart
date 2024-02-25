import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';

class TafserRichTextWidget extends StatelessWidget {
  final String text;
  final String fontSize;

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
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }

      final strippedWord = matchedString.replaceAll(RegExp(r'[{}]'), '');
      textSpans.add(TextSpan(
        text: strippedWord,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontFamily: 'YourCustomFont', // Replace with your desired font
        ),
      ));

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
          fontSize: double.parse(fontSize).sp,
        ),
        children: textSpans,
      ),
      textAlign: TextAlign.justify,
      selectionHeightStyle: BoxHeightStyle.strut,
    );
  }
}
