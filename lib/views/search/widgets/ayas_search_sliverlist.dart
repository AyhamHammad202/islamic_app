import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

import 'aya_search_tile.dart';

class AyasSearchSliverList extends StatelessWidget {
  const AyasSearchSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    final QuranController quranController = Get.find();
    return GetBuilder<QuranController>(
      builder: (c) {
        return SliverList.builder(
          itemCount: quranController.ayasFoundBySearch.length,
          itemBuilder: (context, index) => AyaSearchTile(
            aya: quranController.ayasFoundBySearch[index],
          ),
        );
      },
    );
  }
}
