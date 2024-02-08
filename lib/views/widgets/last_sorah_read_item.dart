import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/cubits/quran_cubit/quran_cubit.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/last_read_model.dart';
import 'package:islamic_app/views/ayat_view.dart';

class LastSorahReadWidget extends StatefulWidget {
  const LastSorahReadWidget({
    super.key,
  });

  @override
  State<LastSorahReadWidget> createState() => _LastSorahReadWidgetState();
}

class _LastSorahReadWidgetState extends State<LastSorahReadWidget> {
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).getLastRead();
    BlocProvider.of<QuranCubit>(context).getAyatOfLastRead(
      BlocProvider.of<QuranCubit>(context).lastPageRead,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        LastReadModel? lastRead = BlocProvider.of<QuranCubit>(context).lastRead;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: InkWell(
            onTap: () {
              setState(() {
                BlocProvider.of<QuranCubit>(context)
                    .getCurrentPageSora(lastRead?.pageNum ?? 1);
                globalPage = (lastRead?.pageNum)! - 1 ?? 1;
                log("Global page = ${globalPage}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AyatView(
                            sorah:
                                BlocProvider.of<QuranCubit>(context).surahs[0])
                        // BlocProvider.of<QuranCubit>(context).allSorahOfQuran[(lastRead?.soraNum) ?? 1]),
                        ));
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: kForthColor,
                  width: 2,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/sorahs/${(lastRead?.soraNum.toString().padLeft(3, "0")) ?? "001"}.svg",
                        colorFilter:
                            ColorFilter.mode(kThirdlyColor, BlendMode.srcIn),
                        width: 130.w,
                      ),
                      Text(
                        lastRead?.soraEnName ?? "Al-Fātiḥah",
                        style: TextStyle(
                          color: kThirdlyColor,
                          fontFamily: kFontKufamItalicVariableFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                    child: VerticalDivider(
                      color: kThirdlyColor,
                      width: 2,
                      thickness: 2,
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "${lastRead?.dateTime ?? ""}",
                        style: TextStyle(
                          color: kThirdlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        "الآية - ${lastRead?.ayaNum.toArabic() ?? 1}",
                        style: TextStyle(
                          color: kThirdlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        "${lastRead?.pageNum.toArabic() ?? 1}",
                        style: TextStyle(
                          color: kThirdlyColor,
                          fontFamily: kFontKufamRegular,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 32.w),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
