import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';

import 'widgets/allah_name_widget.dart';

class AllahNamesView extends StatelessWidget {
  const AllahNamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.of(context).allahNames),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AnimationLimiter(
            child: GetBuilder<QuranController>(
              builder: (c) => ListView.builder(
                itemCount: c.allahNames.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: FadeInAnimation(
                      duration: Durations.medium2,
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: AllahNameWidget(
                          index: index,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
