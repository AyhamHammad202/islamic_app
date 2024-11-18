import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/tasbeha_model.dart';
import 'package:islamic_app/text_themes.dart';

class MasbehaView extends StatelessWidget {
  const MasbehaView({super.key, required this.tasbehaModel});
  final TasbehaModel tasbehaModel;

  @override
  Widget build(BuildContext context) {
    final MesbahaController mesbahaController = Get.find();
    return BackgroundImage(
      child: PopScope(
        onPopInvoked: (didPop) {
          mesbahaController.times.value = 0;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Obx(() {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tasbehaModel.tasbeha,
                      style: TextThemes.tasbehTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    Gap(32.h),
                    Text(
                      tasbehaModel.info,
                      style: TextThemes.tasbehDescTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${tasbehaModel.times} ${S.current.time}",
                      style: TextThemes.tasbehDescTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    Gap(64.h),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 5,
                      width: MediaQuery.sizeOf(context).width / 5,
                      child: Center(
                        child: InkWell(
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            mesbahaController.incretment(tasbehaModel.id - 1);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const ShapeDecoration(
                              color: Color(0xff365C5E),
                              shape: CircleBorder(),
                            ),
                            child: Text(
                              "${mesbahaController.times.value}",
                              style: TextThemes.timesTextStyle(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        mesbahaController.times.value = 0;
                      },
                      icon: const Icon(CupertinoIcons.refresh_thick),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
