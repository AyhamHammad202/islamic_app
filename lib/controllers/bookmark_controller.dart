import 'dart:developer';

import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:quran_library/quran.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkController extends GetxController {
  final DataClient _client = DataClient();
  final QuranController _quranController = Get.find();
  final String _bookmarksTable = "Bookmarks";
  List<AyahModel> ayasWithBookMark = [];
  List<int> bookmarkedAyasID = [];

  @override
  void onInit() async {
    await getAllAyasBookMarks();
    super.onInit();
  }

  Future addAyaBookMark(int idOfAya) async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
      return;
    }
    if (ayasWithBookMark.contains(
      _quranController.ayas[idOfAya - 1],
    )) {
      await deleteAyaBookMark(idOfAya);
      return;
    }
    database.insert(
      _bookmarksTable,
      {
        'AyaID': idOfAya,
      },
    );
    await getAllAyasBookMarks();
  }

  Future getAllAyasBookMarks() async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
      return;
    }
    bookmarkedAyasID.clear();
    ayasWithBookMark.clear();
    var results = await database.query(
      _bookmarksTable,
      // orderBy: "AyaID ASC",
    );
    for (var ayaBookmark in results) {
      bookmarkedAyasID.add(ayaBookmark['AyaID'] as int);
      ayasWithBookMark.addAll(
        _quranController.ayas.where(
          (aya) => aya.ayahUQNumber == ayaBookmark['AyaID'],
        ),
      );
    }
    // for (var element in ayasWithBookMark) {
      // log(element.text);
    // }
    refresh();
  }

  Future deleteAyaBookMark(int ayaID) async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
      return;
    }
    ayasWithBookMark.remove(
      ayasWithBookMark.firstWhere((aya) => aya.ayahUQNumber == ayaID),
    );
    database.delete(_bookmarksTable, where: "AyaID  = $ayaID");
    await getAllAyasBookMarks();
    refresh();
  }
}
