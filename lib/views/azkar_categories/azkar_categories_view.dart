import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/azkar_categories/widgets/category_item.dart';

class AzkarCategoriesView extends StatelessWidget {
  const AzkarCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    AzkarController azkarController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.azkar),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            itemCount: azkarController.categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: azkarController.categories[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
