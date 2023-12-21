import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/sorah_model.dart';
import 'package:islamic_app/views/ayat_view.dart';

import '../../cubits/quran_cubit/quran_cubit.dart';


class SorahTile extends StatelessWidget {
  const SorahTile({super.key, required this.sorah});
  final SorahModel sorah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: InkWell(
        onTap: () {
          BlocProvider.of<QuranCubit>(context)
              .getCurrentPageSora(sorah.pageNum);
          // BlocProvider.of<QuranCubit>(context).getAllAyatOfPage(sorah.pageNum);
          Navigator.pushNamed(context, AyatView.id, arguments: sorah);
        },
        child: Container(
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    kSorahNumberFramAsset,
                  ),
                  Text(
                    "${sorah.id.toArabic()}",
                    style: TextStyle(
                      fontFamily: kFontKufamRegular,
                      color: kThirdlyColor,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/sorahs/${sorah.id.toString().padLeft(3, "0")}.svg",
                // color: kThirdlyColor,
                colorFilter: ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
                width: 100.w,
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    sorah.nameEn,
                    style: TextStyle(
                      color: kThirdlyColor,
                      fontFamily: kFontKufamRegular,
                      fontSize: 14.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${sorah.typeAr}",
                        style: TextStyle(
                          color: kSecondlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                        child: VerticalDivider(
                          color: kSecondlyColor,
                          width: 10.w,
                          thickness: 1.5,
                        ),
                      ),
                      Text(
                        "${sorah.ayaCount} آية",
                        style: TextStyle(
                          color: kSecondlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
