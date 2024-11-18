// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:islamic_app/text_themes.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    required this.isSelected,
  });
  final String icon;
  final bool isSelected;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: isSelected
                ? ColorFilter.mode(
                    Theme.of(context).brightness != Brightness.dark
                        ? Colors.black
                        : Colors.white,
                    BlendMode.srcIn)
                : ColorFilter.mode(
                    Theme.of(context).brightness != Brightness.dark
                        ? Colors.black45
                        : Colors.white54,
                    BlendMode.srcIn),
            width: 30.w,
            height: 25.h,
          ),
          Text(
            title,
            style: TextThemes.navTextStyle(context, isSelected),
          ),
        ],
      ),
    );
  }
}
