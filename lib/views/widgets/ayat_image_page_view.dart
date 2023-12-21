import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/models/sorah_model.dart';
import 'package:islamic_app/views/ayat_view.dart';

import '../../cubits/quran_cubit/quran_cubit.dart';
import 'ayat_image_background.dart';

class AyatImagePageView extends StatefulWidget {
  const AyatImagePageView({
    super.key,
    required this.sorahModel,
    required this.pageController,
  });
  final SorahModel sorahModel;
  final PageController pageController;

  @override
  State<AyatImagePageView> createState() => _AyatImagePageViewState();
}

class _AyatImagePageViewState extends State<AyatImagePageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PageView.builder(
        controller: widget.pageController,
        onPageChanged: (page) {
          setState(() {
            BlocProvider.of<QuranCubit>(context).getCurrentPageSora(page + 1);
            globalPage = page;
          });
        },
        itemCount: 604,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              index >= 2 ? AyatImageBackground() : SizedBox(),
              Image.asset(
                "assets/images/quran_pages/00${index + 1}.png",
                fit: BoxFit.contain,
              ),
              Image.asset(
                "assets/images/quran_pages/000${index + 1}.png",
                fit: BoxFit.contain,
              ),
            ],
          );
        },
      ),
    );
  }
}
