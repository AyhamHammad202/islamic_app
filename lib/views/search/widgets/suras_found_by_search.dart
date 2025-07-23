import 'package:flutter/material.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

import 'sura_search_tile.dart';

class SurasFoundBySearch extends StatelessWidget {
  const SurasFoundBySearch({
    super.key,
    required this.quranController,
  });

  final QuranController quranController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          quranController.searchedSurahs.length,
          (index) => SuraSearchTile(
            ayahModel: quranController.searchedSurahs[index],
          ),
        ),
      ), // var sura = c.surahs[index];
    );
  }
}
