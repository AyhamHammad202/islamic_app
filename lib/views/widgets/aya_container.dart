import 'package:flutter/material.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/models/aya_model.dart';

class AyaContainer extends StatelessWidget {
  const AyaContainer({
    Key? key,
    required this.aya,
  }) : super(key: key);
  final AyaModel aya;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: thirdlyColor,
          ),
          child: Row(
            children: [
              Text(
                "${aya.id}",
                style: TextStyle(
                  color: secondlyColor,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_add,
                  color: secondlyColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: secondlyColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                aya.ar,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: fontUthmanicHafs,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                aya.en,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: fontUthmanicHafs,
                  fontSize: 28,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
