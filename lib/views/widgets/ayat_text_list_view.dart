import 'package:flutter/material.dart';
import 'package:islamic_app/models/aya_model.dart';

import 'aya_item.dart';

class AyatTextListView extends StatelessWidget {
  const AyatTextListView({
    super.key,
    required this.ayat,
  });

  final List<AyatModel> ayat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ayat.length,
      itemBuilder: (context, index) => AyaItem(
        ayat: ayat[index],
      ),
    );
  }
}
