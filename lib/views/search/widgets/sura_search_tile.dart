import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';

import '../../../controllers/quran_controller.dart';
import '../../ayat/ayat_view.dart';

class SuraSearchTile extends StatelessWidget {
  const SuraSearchTile({
    super.key,
    required this.surahModel,
  });

  final SurahModel surahModel;

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return InkWell(
      onTap: () {
        quranController.globalPage.value = surahModel.ayas[0].page - 1;
        quranController.getCurrentPageAyas(surahModel.ayas.first.page - 1);
        Get.to(
          AyatView(
            surahModel: surahModel,
          ),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Theme.of(context)
                .colorScheme
                .secondaryContainer
                .withOpacity(.5),
          ),
        ),
        child: Text(
          surahModel.nameOfSurah,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
