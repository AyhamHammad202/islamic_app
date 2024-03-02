import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:islamic_app/version_one_views/search_view.dart';

import 'package:islamic_app/constants/constant.dart';
import '../../generated/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.advancedDrawerController,
  });
  final AdvancedDrawerController advancedDrawerController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, SearchView.id);
            },
            child: SvgPicture.asset(kSearchAsset),
          ),
        ),
      ],
      title: Text(
        S.of(context).quran,
        style:
            const TextStyle(fontFamily: kFontKufamItalic, color: kThirdlyColor),
      ),
      leading: IconButton(
        onPressed: () {
          advancedDrawerController.showDrawer();
        },
        icon: const Icon(
          Icons.menu_rounded,
          color: kThirdlyColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
