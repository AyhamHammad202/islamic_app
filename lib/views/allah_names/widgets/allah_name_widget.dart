import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            child: Text(
              "${index + 1}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14.sp,
                  ),
            ),
          ),
          Text(
            index == 86
                ? "المعطي المانع"
                : quranController.allahNames[index].name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: index == 86 ? 32.sp : 64.sp,
                  fontFamily: "AllahNames  4",
                ),
          ),
          Text(
            quranController.allahNames[index].meaning,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}
