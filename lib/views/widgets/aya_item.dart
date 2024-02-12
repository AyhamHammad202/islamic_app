import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:islamic_app/constant.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:islamic_app/views/widgets/tafser_richtext_widget.dart';

import 'aya_item_above.dart';

class AyaItem extends StatefulWidget {
  const AyaItem({
    super.key,
    required this.ayat,
  });

  final AyatModel ayat;

  @override
  State<AyaItem> createState() => _AyaItemState();
}

class _AyaItemState extends State<AyaItem> {
  bool isTaffserShowed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AyaItemAbove(ayat: widget.ayat),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: FutureBuilder(
                future: SettingsService().getStringValue("ayaFontSize"),
                builder: (context, snapshot) {
                  return Text(
                    widget.ayat.ayaText,
                    style: TextStyle(
                      fontFamily: kFontUthmanicHafs,
                      color: Colors.black,
                      fontSize: double.parse(snapshot.data ?? "24").sp,
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                      color: Color(0xffC39B7B),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    children: [
                      // Text(
                      //   "تفسير السعدي",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontFamily: kFontKufamRegular,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isTaffserShowed = !isTaffserShowed;
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        selectedIcon: Icon(Icons.arrow_drop_up_outlined),
                        isSelected: isTaffserShowed,
                        iconSize: 32,
                        color: Colors.white,
                        style: ButtonStyle(
                          animationDuration: Duration(
                            seconds: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Divider(
                    indent: 20.w,
                    color: Color(0xffC39B7B),
                    thickness: 2,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isTaffserShowed,
            child: FutureBuilder(
                future: SettingsService().getStringValue("fontSize"),
                builder: (context, snapshot) {
                  if (snapshot.data == null)
                    return TafserRichTextWidget(
                      text: widget.ayat.taffser,
                      fontSize: "16",
                    );
                  return TafserRichTextWidget(
                      text: widget.ayat.taffser, fontSize: snapshot.data!);
                }),
          ),
        ],
      ),
    );
  }
}
