import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/surah_model.dart';


import 'widgets/ayat_image_page_view.dart';
import 'widgets/ayat_text_page_view.dart';

// int globalPage = 0;

class AyatView extends StatelessWidget {
  const AyatView({super.key, required this.sorah});
  static const String id = "Ayat-View";
  final SurahModel sorah;

  @override
  Widget build(BuildContext context) {
    // PageController pageController =PageController(initialPage: globalPage, keepPage: false);
    QuranController quranController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme: const IconThemeData(color: kThirdlyColor),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kThirdlyColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              quranController.isMushafMode.value =
                  !quranController.isMushafMode.value;
            },
            icon: Image.asset(
              kTransferAsset,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: GetX<QuranController>(
        builder: (controller) {
          quranController.pageController = PageController(
              initialPage: quranController.globalPage.value, keepPage: true);
          return controller.isMushafMode.value
              ? AyatImagePageView(
                  sorahModel: sorah,
                )
              : AyatTextPageView(
                  sorah: sorah,
                );
        },
      ),
    );
  }
}
