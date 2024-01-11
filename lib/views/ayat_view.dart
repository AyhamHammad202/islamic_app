import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/constant.dart';
import '../../cubits/quran_cubit/quran_cubit.dart';

import 'package:islamic_app/models/sorah_model.dart';

import 'widgets/ayat_image_page_view.dart';
import 'widgets/ayat_text_page_view.dart';

int globalPage = 0;

class AyatView extends StatefulWidget {
  const AyatView({super.key, required this.sorah});
  static const String id = "Ayat-View";
  final SorahModel sorah;

  @override
  State<AyatView> createState() => _AyatViewState();
}

class _AyatViewState extends State<AyatView> {
  bool isImageView = true;
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
                isImageView = !isImageView;
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
        title: BlocBuilder<QuranCubit, QuranState>(
          builder: (context, state) {
            if (state is QuranDone) {
              pages = BlocProvider.of<QuranCubit>(context).currentPage;
              return SvgPicture.asset(
                "assets/images/sorahs/${pages!.first.soraNum.toString().padLeft(3, "0")}.svg",
                width: 110.w,
                colorFilter: ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      body: isImageView
          ? AyatImagePageView(
              sorahModel: widget.sorah,
              pageController: pageController,
            )
          : AyatTextPageView(
              sorah: widget.sorah,
              pageController: pageController,
            ),
    );
  }
}
