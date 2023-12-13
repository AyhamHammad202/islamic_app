import 'package:flutter/material.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/models/sura_model.dart';

class SuraInfoContainer extends StatelessWidget {
  const SuraInfoContainer({
    super.key,
    required this.sura,
  });

  final SuraModel sura;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 8),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xfffceddc),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
            child: SizedBox(
              width: 145,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sura.nameTranslation,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    sura.titleEn,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondlyColor,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${sura.allAya.length} Verses",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondlyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    sura.place,
                    style: TextStyle(
                      fontSize: 16,
                      color: secondlyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Image.asset(
            book,
            scale: 5,
          )
        ],
      ),
    );
  }
}
