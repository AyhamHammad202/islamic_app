import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/surah_model.dart';

import '../../cubits/quran_cubit/quran_cubit.dart';

class AyatImagePageView extends StatefulWidget {
  const AyatImagePageView({
    super.key,
    required this.sorahModel,
    required this.pageController,
  });
  final SurahModel sorahModel;
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
        itemCount: 604,
        itemBuilder: (context, page) {
          BlocProvider.of<QuranCubit>(context).getAyasForCurrentPage(page + 1);
          List<AyaOfSurahModel> ayas =
              BlocProvider.of<QuranCubit>(context).ayas;
          final List<LongPressGestureRecognizer> _longPressGestureRecognizer =
              [];
          List<bool> isSelected = [];
          for (var i = 0; i < ayas.length; i++) {
            isSelected.add(false);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: kSecondlyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "الجزء:" + ayas.first.juz.toArabic(),
                        style: TextStyle(
                          fontFamily: kFontKufamRegular,
                          fontSize: getProportionateScreenWidth(12),
                          color: kPrimaryColor,
                        ),
                      ),
                      Text(
                        "الصفحة:" + ayas.first.page.toArabic(),
                        style: TextStyle(
                          fontFamily: kFontKufamRegular,
                          fontSize: getProportionateScreenWidth(12),
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                RichText(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'page${page + 1}',
                      fontSize: getProportionateScreenWidth(22),
                      letterSpacing: .01,
                      wordSpacing: .01,
                      height: 1.5.h,
                      color: Colors.black,
                    ),
                    children: List.generate(
                      ayas.length,
                      (index) {
                        isSelected.add(false);
                        _longPressGestureRecognizer
                            .add(LongPressGestureRecognizer()
                              ..onLongPress = () {
                                setState(() {
                                  isSelected[index] = !isSelected[index];
                                });
                                log("Aya=${ayas[index].textOfAya}");
                                log("Aya=${isSelected[index]}");
                              });
                        return TextSpan(
                          text: index == 0
                              ? "${ayas[index].text[0]} ${ayas[index].text.substring(1)}"
                              : ayas[index].text,
                          recognizer: _longPressGestureRecognizer[index],
                          style: TextStyle(
                            backgroundColor: isSelected[0] ? Colors.blue : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
// Stack(
//   alignment: Alignment.center,
//   children: [
//     index >= 2 ? AyatImageBackground() : SizedBox(),
//     Image.asset(
//       "assets/images/quran_pages/00${index + 1}.png",
//       fit: BoxFit.contain,
//     ),
//     Image.asset(
//       "assets/images/quran_pages/000${index + 1}.png",
//       fit: BoxFit.contain,
//     ),
//   ],
// );
