import 'package:flutter/material.dart';
import 'package:islamic_app/generated/l10n.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.menu,
        ),
        SizedBox(width: 8),
        Text(
          S.of(context).appName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.search),
      ],
    );
  }
}
