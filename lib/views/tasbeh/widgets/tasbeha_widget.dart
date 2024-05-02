import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/text_themes.dart';
import 'package:islamic_app/views/masbeha/masbeha_view.dart';

class TasbehaWidget extends StatelessWidget {
  const TasbehaWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final MesbahaController mesbahaController = Get.find();
    return GetBuilder<MesbahaController>(builder: (c) {
      return InkWell(
        onTap: () {
          Get.to(
            () => MasbehaView(
              tasbehaModel: mesbahaController.tasbeh[index],
            ),
            // transition: Transition.upToDown,
            // duration: const Duration(
            //   milliseconds: 300,
            // ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            children: [
              SvgPicturesMethods.mesbahaIcon(),
              Gap(8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mesbahaController.tasbeh[index].tasbeha,
                      style: TextThemes.tasbehTextStyle(context),
                    ),
                    Text(
                      "${mesbahaController.tasbeh[index].times} ${S.of(context).time}",
                      style: TextThemes.tasbehDescTextStyle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
