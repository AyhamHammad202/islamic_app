// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:islamic_app/constants/constant.dart';
// import 'package:islamic_app/controllers/quran_controller.dart';
// import 'package:islamic_app/services/last_read_service.dart';
// import 'package:islamic_app/version_one_views/ayat_view.dart';

// class LastSorahReadWidget extends StatelessWidget {
//   const LastSorahReadWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     LastReadService settingsService = Get.find();
//     QuranController quranController = Get.find();
//     return GetX<LastReadService>(
//       builder: (controller) => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: InkWell(
//           onTap: () {
//             quranController.globalPage.value =
//                 settingsService.lastPageRead.value - 1;
//             quranController
//                 .getCurrentPageAyas(settingsService.lastPageRead.value - 1);
//             Navigator.pushNamed(context, AyatView.id,
//                 arguments: quranController
//                     .surahs[settingsService.lastSuraNumRead.value]);
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 6.h),
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.circular(8.r),
//               border: Border.all(
//                 color: kForthColor,
//                 width: 2,
//               ),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     SvgPicture.asset(
//                       "assets/images/sorahs/00${settingsService.lastSuraNumRead}.svg",
//                       colorFilter: const ColorFilter.mode(
//                           kThirdlyColor, BlendMode.srcIn),
//                       width: 130.w,
//                     ),
//                     Text(
//                       quranController
//                           .surahs[settingsService.lastSuraNumRead.value - 1]
//                           .englishNameOfSurah,
//                       style: TextStyle(
//                         color: kThirdlyColor,
//                         fontFamily: kFontKufamItalicVariableFont,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 50.h,
//                   child: const VerticalDivider(
//                     color: kThirdlyColor,
//                     width: 2,
//                     thickness: 2,
//                   ),
//                 ),
//                 const Spacer(),
//                 Column(
//                   children: [
//                     Text(
//                       "صفحة - ${settingsService.lastPageRead.value}",
//                       style: TextStyle(
//                         color: kThirdlyColor,
//                         fontFamily: kFontKufamRegular,
//                         fontSize: 18.sp,
//                       ),
//                     ),
//                     Text(
//                       "الآية - ${settingsService.lastAyaNumRead.value}",
//                       style: TextStyle(
//                         color: kThirdlyColor,
//                         fontFamily: kFontKufamRegular,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     Text(
//                       settingsService.lastDateRead.value,
//                       style: TextStyle(
//                         color: kThirdlyColor.withOpacity(.8),
//                         fontFamily: kFontKufamRegular,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: 32.w),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // setState(() {
// //                 BlocProvider.of<QuranCubit>(context)
// //                     .getCurrentPageSora(lastRead?.pageNum ?? 1);
// //                 globalPage = (lastRead?.pageNum)! - 1 ?? 1;
// //                 log("Global page = ${globalPage}");
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => AyatView(
// //                             sorah:
// //                                 BlocProvider.of<QuranCubit>(context).surahs[0])
// //                         // BlocProvider.of<QuranCubit>(context).allSorahOfQuran[(lastRead?.soraNum) ?? 1]),
// //                         ));
// //               });