import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';
import '../../generated/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SvgPicture.asset(kSearchAsset),
        ),
      ],
      title: Text(
        S.of(context).quran,
        style: TextStyle(fontFamily: kFontKufamItalic, color: kThirdlyColor),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.menu_rounded,
          color: kThirdlyColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
