import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(
      {super.key, required this.title, required this.svgIcon, this.onTap});
  final String title;
  final Widget svgIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            const Spacer(),
            svgIcon,
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
