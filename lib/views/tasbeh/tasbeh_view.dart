import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/tasbeh/widgets/tasbeha_widget.dart';

class TasbehView extends StatelessWidget {
  const TasbehView({super.key});

  @override
  Widget build(BuildContext context) {
    final MesbahaController mesbahaController = Get.find();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.of(context).tasbeh,
          ),
        ),
        body: GetBuilder<MesbahaController>(builder: (c) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ListView.builder(
              itemCount: mesbahaController.tasbeh.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FadeInAnimation(
                    duration: Durations.medium2,
                    child: SlideAnimation(
                      verticalOffset: 50,
                      child: TasbehaWidget(
                        index: index,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
