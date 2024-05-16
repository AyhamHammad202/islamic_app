import 'package:flutter/material.dart';
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
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(.6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 38.r,
            backgroundColor: Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: 36.r,
              backgroundImage: AssetImage(
                readerModel.image,
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
            child: VerticalDivider(
              color: Theme.of(context).dividerColor,
            ),
          ),
          Column(
            children: [
              Text(
                Get.locale == const Locale('ar')
                    ? readerModel.arabicName
                    : readerModel.englishName,
                style: TextThemes.readerTextStyle(context),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
