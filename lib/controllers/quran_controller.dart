import 'dart:convert';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';

import 'package:get/get.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:sqflite/sqflite.dart';

class QuranController extends GetxController {
  Data2Client _client = Data2Client();
  List<SurahModel> surahs = [];
  List<List<AyaOfSurahModel>> pages = [];
  List<AyaOfSurahModel> allAyas = [];

  List<String> tafserOfPage = [];

  var selectedAyahIndexes = <int>[].obs;
  bool isSelected = false;
  PreferDirection preferDirection = PreferDirection.topCenter;

  RxBool isMushafMode = true.obs;

  void toggleAyahSelection(int index) {
    if (selectedAyahIndexes.contains(index)) {
      selectedAyahIndexes.remove(index);
    } else {
      selectedAyahIndexes.clear();
      selectedAyahIndexes.add(index);
      selectedAyahIndexes.refresh();
    }
    selectedAyahIndexes.refresh();
  }

  void clearSelection() {
    if (selectedAyahIndexes.isNotEmpty) {
      selectedAyahIndexes.clear();
    } else {
      // sl<GeneralController>().showControl();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await loadQuran();
  }

  Future<void> loadQuran() async {
    String jsonString = await rootBundle.loadString("assets/data/quranV2.json");
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> surahsJson = jsonResponse['data']['surahs'];
    surahs = surahsJson.map((e) => SurahModel.fromMap(e)).toList();

    for (var surah in surahs) {
      allAyas.addAll(surah.ayas);
      log('Added ${surah.nameOfSurah} ayahs');
      update();
    }
    List.generate(
      604,
      (pageIndex) {
        pages.add(allAyas.where((ayah) => ayah.page == pageIndex + 1).toList());
      },
    );
    log('Pages Length: ${pages.length}', name: 'Quran Controller');
  }

  List<List<AyaOfSurahModel>> getCurrentPageAyahsSeparatedForBasmala(
          int pageIndex) =>
      pages[pageIndex]
          .splitBetween((f, s) => f.numberOfAyaInSurah > s.numberOfAyaInSurah)
          .toList();

  List<AyaOfSurahModel> getCurrentPageAyas(int pageIndex) => pages[pageIndex];

  int getSurahNumberFromPage(int pageNumber) {
    log("pageeeeeeee" + pageNumber.toString());
    return surahs
        .firstWhere(
            (s) => s.ayas.contains(getCurrentPageAyas(pageNumber).first))
        .numberOfSurah;
  }

  int getSurahNumberByAya(AyaOfSurahModel aya) =>
      surahs.firstWhere((s) => s.ayas.contains(aya)).numberOfSurah;

  String getSurahNameFromPage(int pageNumber) {
    try {
      return surahs
          .firstWhere(
              (s) => s.ayas.contains(getCurrentPageAyas(pageNumber).first))
          .nameOfSurah;
    } catch (e) {
      // Handle the error or return a default/fallback value
      return "Surah not found"; // Or any other fallback logic you prefer
    }
  }

  void GetAyaTafser(int page) async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      return null;
    }
    List results = (await database.query("saadi",
            columns: [
              '"index"',
              'sura',
              'aya',
              'text',
              'pageNum',
            ],
            where: "PageNum=${page}",
            orderBy: '"index"'))
        .cast<Map>();
    tafserOfPage = [];
    results.forEach((element) {
      // log(element['text']);
      tafserOfPage.add(element['text']);
    });
    log('Tafser leanth======${tafserOfPage.length}');
    // refresh();
  }
}
