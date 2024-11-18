import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/views/azkar/widgets/zkar.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    AzkarController azkarController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(category),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            itemCount: azkarController.filterdAzkar.length,
            itemBuilder: (context, index) {
              return Zkar(
                zekrModel: azkarController.filterdAzkar[index],
                zkarNumber: index + 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
