import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/generated/l10n.dart';

import 'package:islamic_app/models/zekr_model.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';

class Zkar extends StatelessWidget {
  const Zkar({
    super.key,
    required this.zekrModel,
    required this.zkarNumber,
  });
  final ZekrModel zekrModel;
  final int zkarNumber;

  @override
  Widget build(BuildContext context) {
    AzkarController azkarController = Get.find();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.justify,
            zekrModel.zekr,
            style: TextThemes.zkarTextStyle(context),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "$zkarNumber",
                  style: TextThemes.zkarTimesTextStyle(context),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 32.h,
                  child: VerticalDivider(
                    endIndent: 10.h,
                    color: Theme.of(context).dividerColor,
                    thickness: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${zekrModel.count} ${zekrModel.count >= 3 ? S.of(context).times : S.of(context).time}",
                  style: TextThemes.zkarTimesTextStyle(context),
                ),
              ),
              const Spacer(),
              Gap(4.w),
              InkWell(
                onTap: () {
                  azkarController.shareZkar(zekrModel, context);
                },
                child: SvgPicturesMethods.shareIcon(height: 24.h),
              ),
              Gap(12.w),
              InkWell(
                onTap: () {
                  azkarController.copyZkar(zekrModel, context);
                },
                child: SvgPicturesMethods.copyIcon(height: 24.h),
              ),
            ],
          )
        ],
      ),
    );
  }
}
