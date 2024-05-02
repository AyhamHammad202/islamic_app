import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/text_themes.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});
  final String title;
  final Widget leading;
  final void Function()? onTap;

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
        style: TextThemes.drawerItemTextStyle(context),
      ),
      onTap: onTap,
    );
  }
}
