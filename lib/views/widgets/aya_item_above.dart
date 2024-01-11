import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/views/widgets/custom_botton.dart';
import 'package:share_plus/share_plus.dart';

class AyaItemAbove extends StatelessWidget {
  const AyaItemAbove({
    super.key,
    required this.ayat,
  });

  final AyatModel ayat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: kThirdlyColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset("assets/images/frame_arrow.svg"),
                SvgPicture.asset("assets/images/frame_back_comp.svg"),
                SvgPicture.asset("assets/images/frame_colored.svg"),
                Text(
                  "${ayat.ayaNumber.toArabic()}",
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                ayat.soraNameAr,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: kFontKufamItalicVariableFont,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Spacer(),
            CustomBotton(
              image: "assets/images/copyyy.png",
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                  text:
                      "{ ${ayat.ayaText.substring(0, ayat.ayaText.length - 2)} }\n${ayat.soraNameAr} الآية:${ayat.ayaNumber}",
                ));
              },
            ),
            CustomBotton(
              image: "assets/images/sharee.png",
              onTap: () {
                Share.share(
                    "{ ${ayat.ayaText.substring(0, ayat.ayaText.length - 2)} }\n${ayat.soraNameAr} الآية:${ayat.ayaNumber}\nالتفسير:${ayat.taffser}");
              },
            ),
          ],
        ),
      ),
    );
  }

}
