import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/azkar/azkar_view.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    AzkarController azkarController = Get.find();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: InkWell(
        onTap: () {
          azkarController.getFilterdAzkar(category);
          Get.to(
            () => AzkarView(
              category: category,
            ),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: Row(
          children: [
            SvgPicturesMethods.azkarIcon(),
            // Gap(4.w),
            SizedBox(
              height: 15.h,
              child: VerticalDivider(
                color: Theme.of(context).dividerColor,
              ),
            ),
            Expanded(
              child: Text(
                category,
                style: TextThemes.categoryTextStyle(context),
              ),
            ),
            // const Spacer(),
            Gap(4.w),
            SvgPicturesMethods.arrowIcon(),
            Gap(4.w),
          ],
        ),
      ),
    );
  }
}
