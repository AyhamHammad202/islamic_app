import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/text_themes.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({
    super.key,
    required this.readerModel,
  });
  final ReaderModel readerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.4),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 38.r,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            child: CircleAvatar(
              radius: 36.r,
              backgroundImage: AssetImage(
                readerModel.image,
              ),
            ),
          ),
          SizedBox(
            width: 25.w,
            child: Divider(
              color: Theme.of(context).dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              Get.locale == const Locale('ar')
                  ? readerModel.arabicName
                  : readerModel.englishName,
              style: TextThemes.readerTextStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
