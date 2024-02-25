import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
  });
  final IconData leadingIcon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        color: kThirdlyColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: kThirdlyColor,
          fontSize: 24.sp,
          fontFamily: kFontKufamItalic,
        ),
      ),
    );
  }
}
