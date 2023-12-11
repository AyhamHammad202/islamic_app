import 'package:flutter/material.dart';

class LastReadItem extends StatelessWidget {
  const LastReadItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xfffceddc), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(
            "Al-Baqarah",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            "Verse 285",
            style: TextStyle(
              color: Color(0xff9e7948),
            ),
          ),
        ],
      ),
    );
  }
}
