import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/views/ayat_view.dart';

import '../../constant.dart';
import '../../cubits/cubit/quran_cubit.dart';
import '../../models/aya_model.dart';
import '../../models/sorah_model.dart';
import 'ayat_text_list_view.dart';

class AyatTextPageView extends StatefulWidget {
  const AyatTextPageView(
      {super.key, required this.sorah, required this.pageController});
  final SorahModel sorah;

  final PageController pageController;
  @override
  State<AyatTextPageView> createState() => _AyatTextPageViewState();
}

class _AyatTextPageViewState extends State<AyatTextPageView> {
  _AyatTextPageViewState();
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).getAllAyatOfPage(globalPage + 1);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return PageView.builder(
            controller: widget.pageController,
            itemCount: 604,
            onPageChanged: (page) {
              setState(() {
                globalPage = page;
                BlocProvider.of<QuranCubit>(context)
                    .getAllAyatOfPage(globalPage + 1);
              });
            },
            itemBuilder: (context, index) {
              List<AyatModel> ayat =
                  BlocProvider.of<QuranCubit>(context).ayatOfPage!;
              return AyatTextListView(ayat: ayat);
            });
      },
    );
  }
}

