import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/text_themes.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelected,
  });
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(isSelected ? 8.r : 4.r)),
        child: Text(
          title,
          style: TextThemes.tabTextStyle.copyWith(
            color: isSelected
                ? TextThemes.tabTextStyle.color
                : TextThemes.tabTextStyle.color!.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
