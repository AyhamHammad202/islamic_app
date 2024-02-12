import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/surah_model.dart';
import '../../cubits/quran_cubit/quran_cubit.dart';

import 'package:islamic_app/models/sorah_model.dart';

import 'widgets/ayat_image_page_view.dart';
import 'widgets/ayat_text_page_view.dart';

int globalPage = 0;

class AyatView extends StatefulWidget {
  const AyatView({super.key, required this.sorah});
  static const String id = "Ayat-View";
  final SurahModel sorah;

  @override
  State<AyatView> createState() => _AyatViewState();
}

class _AyatViewState extends State<AyatView> {
  List<PageModel>? pages;

  @override
  void initState() {
    // BlocProvider.of<QuranCubit>(context).getCurrentPageSora(widget.sorah.pageNum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: globalPage, keepPage: false);
    QuranController quranController = Get.find();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: kThirdlyColor),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: kThirdlyColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                quranController.isMushafMode.value =
                    !quranController.isMushafMode.value;
              });
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
      body: GetBuilder<QuranController>(
        builder: (controller) {
          return controller.isMushafMode.value
              ? AyatImagePageView(
                  sorahModel: widget.sorah,
                  pageController: pageController,
                )
              : AyatTextPageView(
                  sorah: widget.sorah,
                  pageController: pageController,
                );
        },
      ),
    );
  }
}
