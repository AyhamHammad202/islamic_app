import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/svg_pictures.dart';
import 'package:islamic_app/views/surah_info/surah_info_view.dart';

class SuraTile extends StatelessWidget {
  const SuraTile({
    super.key,
    required this.index,
    this.onTap,
  });

  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicturesMethods.suraNumBorderIcon(),
                Text(
                  quranController.surahs[index].numberOfSurah.toArabic(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(
                  "assets/images/sorahs/00${quranController.surahs[index].numberOfSurah}.svg",
                  height: 42.h,
                  width: 100.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xffD7A664),
                    BlendMode.srcIn,
                  ),
                ),
                Gap(4.h),
                Text(
                  "${quranController.surahs[index].ayas.length} ${S.of(context).ayas}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            const Spacer(),
            Text(
              quranController.surahs[index].revelationType,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {
                Get.to(
                  () => SurahInfoView(
                    surahModel: quranController.surahs[index],
                  ),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 300),
                );
              },
              child: SvgPicturesMethods.alertCircleIcon(),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
