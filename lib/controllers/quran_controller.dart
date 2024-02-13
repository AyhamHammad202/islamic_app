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
  List<AyaOfSurahModel> ayasFoundBySearch = [];

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

  List<SurahModel> surasFoundbySearch = [];
  void searchForAyas(String searchText) {
    try {
      ayasFoundBySearch.clear();
      surasFoundbySearch.clear();
      log("Start Searching for ${searchText}");
      var results =
          allAyas.where((aya) => aya.searchTextOfAya.contains(searchText));
      results.forEach(
        (aya) {
          ayasFoundBySearch.add(aya);
        },
      );
      var surasResults = surahs.where((sura) =>
          removeDiacritics(sura.nameOfSurah).substring(5).contains(searchText));
      surasResults.forEach(
        (element) {
          surasFoundbySearch.add(element);
        },
      );
      log(removeDiacritics(surahs.first.nameOfSurah));
      refresh();
    } catch (e) {
      log("Search Error ${e.toString()}");
    }
  }

  // Map<int, int> indexMapping = {};
  String removeDiacritics(String input) {
    final diacriticsMap = {
      'أ': 'ا',
      'إ': 'ا',
      'آ': 'ا',
      'ٱ': 'ا',
      'إٔ':
          'ا', // These mappings already seem comprehensive, but double inclusion for clarity
      'إٕ': 'ا',
      'إٓ': 'ا',
      'أَ': 'ا',
      'إَ': 'ا',
      'آَ': 'ا',
      'إُ': 'ا',
      'إٌ': 'ا',
      'إً': 'ا',
      // 'ة': 'ه',
      'ً': '',
      'ٌ': '',
      'ٍ': '',
      'َ': '',
      'ُ': '',
      'ِ': '',
      'ّ': '',
      'ْ': '',
      'ـ': '',
      // Adding more comprehensive handling for combinations and less common diacritics
      'ٰ': '', // Dagger alif (small alif on top of characters)
      'ٖ': '', // Kharijatayn (small noon)
      'ٗ': '', // Inverted damma
      'ٕ': '', // Small kasra
      'ٓ': '', // Maddah above
      'ۖ': '', // Small high seen
      'ۗ': '', // Small high rounded zero
      'ۘ': '', // Small high upright rectangular zero
      'ۙ': '', // Small high dotless head of khah
      'ۚ': '', // Small high meem isolated form
      'ۛ': '', // Small low seen
      'ۜ': '', // Small waw
      '۝': '', // Small yeh
      '۞': '', // Small high noon
      '۟': '', // Empty centre low stop
      '۠': '', // Empty centre high stop
      'ۡ': '', // Rounded high stop with filled centre
      'ۢ': '', // Small low meem
    };

    StringBuffer buffer = StringBuffer();
    Map<int, int> indexMapping =
        {}; // Ensure indexMapping is declared if not already globally declared
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      String? mappedChar = diacriticsMap[char];
      if (mappedChar != null) {
        buffer.write(mappedChar);
        if (mappedChar.isNotEmpty) {
          indexMapping[buffer.length - 1] = i;
        }
      } else {
        buffer.write(char);
        indexMapping[buffer.length - 1] = i;
      }
    }
    return buffer.toString();
  }
}
