import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String id = "Search-View";

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    return Scaffold(
      body: GetBuilder<QuranController>(
        builder: (controller) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "أبحث بأستخدام الآية أو رقم الصفحة أو اسم السورة",
                    hintStyle: const TextStyle(
                      fontFamily: kFontNotoNaskhArabic,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r))),
                onChanged: (value) {
                  quranController.searchForAyas(value.trim());
                },
              ),
            ),
            SliverToBoxAdapter(
              child: quranController.ayasFoundBySearch.isEmpty &&
                      quranController.surasFoundbySearch.isEmpty
                  ? const Center(
                      child: Text("Please Search"),
                    )
                  : const SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: quranController.surasFoundbySearch.isNotEmpty
                  ? const SearchViewBody()
                  : null,
            ),
            SliverList.builder(
              itemCount: quranController.ayasFoundBySearch.length,
              itemBuilder: (context, index) {
                return AyaSearchTile(
                    ayaOfSurahModel: quranController.ayasFoundBySearch[index]);
              },
            ),
            // SizedBox(
            //   height: 300,
            //   child: SliverToBoxAdapter(
            //     child: quranController.ayasFoundBySearch.isNotEmpty
            //         ? ListView.builder(
            //             itemCount: quranController.ayasFoundBySearch.length,
            //             itemBuilder: (context, index) => AyaSearchTile(
            //               ayaOfSurahModel: quranController.ayasFoundBySearch[index],
            //             ),
            //           )
            //         : SizedBox.shrink(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
