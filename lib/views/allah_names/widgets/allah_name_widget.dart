import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/text_themes.dart';

class AllahNameWidget extends StatelessWidget {
  const AllahNameWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: 8.w, left: 8.w, top: 4.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Text(
              "${index + 1}",
              style: TextThemes.nameIndexTextStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            index == 86
                ? "المعطي المانع"
                : quranController.allahNames[index].name,
            style: TextStyle(
              fontSize: index == 86 ? 32.sp : 64.sp,
              fontFamily: "AllahNames4",
            ),
          ),
          Text(
            quranController.allahNames[index].meaning,
            style: TextThemes.allahNameTextStyle(context),
          ),
        ],
      ),
    );
  }
}
