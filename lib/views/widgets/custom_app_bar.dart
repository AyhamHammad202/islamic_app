
import 'package:flutter/material.dart';

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
          "Al Quran",
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
