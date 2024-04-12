import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/text_themes.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.title,
      required this.leading,
      required this.toScreen});
  final String title;
  final Widget leading;
  final Widget toScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 24.h,
        width: 24.w,
        child: leading,
      ),
      title: Text(
        title,
        style: TextThemes.drawerItemTextStyle,
      ),
      onTap: () {
        Get.to(
          () => toScreen,
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
