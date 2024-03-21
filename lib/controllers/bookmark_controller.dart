import 'dart:developer';

import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:sqflite/sqflite.dart';

class BookMarkController extends GetxController {
  final DataClient _client = DataClient();
  final QuranController _quranController = Get.find();
  final String _bookmarksTable = "Bookmarks";
  List<AyaOfSurahModel> ayasWithBookMark = [];
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
      _quranController.allAyas[idOfAya - 1],
    )) {
      await deleteAyaBookMark(idOfAya);
      Get.showSnackbar(
        const GetSnackBar(
          message: "تم حذف الآية من المفضلة",
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    database.insert(
      _bookmarksTable,
      {
        'AyaID': idOfAya,
      },
    );
    Get.showSnackbar(
      const GetSnackBar(
        message: "الاية أضيفت",
        duration: Duration(seconds: 1),
      ),
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
        _quranController.allAyas.where(
          (aya) => aya.uniqueIdOfAya == ayaBookmark['AyaID'],
        ),
      );
    }
    for (var element in ayasWithBookMark) {
      log(element.textOfAya);
    }
    refresh();
  }

  Future deleteAyaBookMark(int ayaID) async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
      return;
    }
    ayasWithBookMark.remove(
      ayasWithBookMark.firstWhere((aya) => aya.uniqueIdOfAya == ayaID),
    );
    database.delete(_bookmarksTable, where: "AyaID  = $ayaID");
    await getAllAyasBookMarks();
    refresh();
  }
}
