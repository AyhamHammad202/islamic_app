import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/helper.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    BookMarkController bookMarkController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookMark Ayat"),
      ),
      body: GetBuilder<BookMarkController>(builder: (controller) {
        return SafeArea(
          child: bookMarkController.ayasWithBookMark.isNotEmpty
              ? AAAAAAAAAAAA(bookMarkController: bookMarkController)
              : const Center(
                  child: Text("There is no bookmarks"),
                ),
        );
      }),
    );
  }
}

class AAAAAAAAAAAA extends StatelessWidget {
  const AAAAAAAAAAAA({
    super.key,
    required this.bookMarkController,
  });

  final BookMarkController bookMarkController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          bookMarkController.ayasWithBookMark.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onDoubleTap: () {
                bookMarkController.deleteAyaBookMark(
                    bookMarkController.ayasWithBookMark[index].uniqueIdOfAya);
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "صفحة ${bookMarkController.ayasWithBookMark[index].page.toArabic()}",
                          style: const TextStyle(
                            fontFamily: kFontKufamItalic,
                            color: Colors.red,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          "آية ${bookMarkController.ayasWithBookMark[index].numberOfAyaInSurah.toArabic()}",
                          style: const TextStyle(
                            fontFamily: kFontKufamItalic,
                            color: Colors.red,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      bookMarkController.ayasWithBookMark[index].text
                          .replaceAll("\n", ""),
                      style: TextStyle(
                        fontFamily:
                            "page${bookMarkController.ayasWithBookMark[index].page}",
                        color: Colors.red,
                        fontSize: 22,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
