import 'package:flutter/material.dart';
import 'package:islamic_app/constant.dart';

class LastReadItem extends StatelessWidget {
  const LastReadItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 8, bottom: 8, end: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xfffceddc), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Al-Baqarah",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            "Verse 285",
            style: TextStyle(
              color: secondlyColor,
            ),
          ),
        ],
      ),
    );
  }
}
