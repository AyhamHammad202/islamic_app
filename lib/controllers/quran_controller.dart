import 'dart:convert';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/models/surah_info.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:sqflite/sqflite.dart';

import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/surah_model.dart';

import '../models/allah_name_model.dart';

class QuranController extends GetxController {
  RxBool isUpdateAvailable = false.obs;
  RxBool isUpdateCompluted = false.obs;
  var shorebirdCodePush = ShorebirdCodePush();

  final DataClient _client = DataClient();
  List<SurahModel> surahs = [];
  List<SurahInfoModel> suarhsInfo = [];
  List<AllahNameModel> allahNames = [];
  List<List<AyaOfSurahModel>> pages = [];
  List<AyaOfSurahModel> allAyas = [];
  List<AyaOfSurahModel> ayasFoundBySearch = [];
  List<String> tables = [];
  RxBool isClickedOnPage = false.obs;

  Map<int, String> mapOfTafser = {};

  RxList selectedAyahIndexes = <int>[].obs;
  // RxList showAyahTafserIndexes = <int>[].obs;
  RxInt globalPage = 0.obs;
  late PageController pageController;
  late AdvancedDrawerController advancedDrawerController;
  late ScrollController homePageScrollerController;
  bool isSelected = false;
  PreferDirection preferDirection = PreferDirection.topCenter;
  RxBool isMushafMode = true.obs;

  @override
  void onInit() async {
    super.onInit();
    advancedDrawerController = AdvancedDrawerController();
    homePageScrollerController = ScrollController();
    homePageScrollerController.addListener(() {
      // log("OFFEST ${homePageScrollerController.position}");
      // if (homePageScrollerController.offset>homePageScrollerController) {}
    });
    await loadQuran();
    await getTableNames();
    await loadQuranSurahsInfo();
    await getAyaTafser();
    await loadAllahNames();
    await updateApp();
  }

  Future updateApp() async {
    shorebirdCodePush
        .currentPatchNumber()
        .then((value) => log('current patch number is $value'));
    isUpdateAvailable.value =
        await shorebirdCodePush.isNewPatchAvailableForDownload();
    update();
    await shorebirdCodePush.downloadUpdateIfAvailable();
    isUpdateCompluted.value = true;

    update();
  }

  Future getTableNames() async {
    tables = [];
    var db = await _client.database;
    final List<Map<String, dynamic>> t2ables =
        await db!.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    t2ables.map((row) {
      tables.add(row['name']);
    }).toList();
  }

  @override
  void onClose() {
    log("onClose method called");
    pageController.dispose();
    advancedDrawerController.dispose();
    super.onClose();
  }

  int calucate(int year, int month, int day) {
    HijriCalendar hijriCalendar = HijriCalendar();
    DateTime start = DateTime.now();
    DateTime end = hijriCalendar.hijriToGregorian(year, month, day);
    if (!start.isAfter(end)) {
      // this if the end date is aftar the start date will do this logic
      return DateTimeRange(start: start, end: end).duration.inDays;
    } else {
      // this if the end date is before the start date will do the else logic
      // end = end.copyWith(year: end.year + 1); // uncomment this if you want to make it calucate the next year occasion
      // return DateTimeRange(start: end, end: start).duration.inDays; // you can make this like مضى X ايام
      return 0;
    }
  }

  double calculateProgress(int currentIndex, int total) {
    int totalPages = total;
    if (currentIndex < 1) {
      return 0.0;
    }
    if (currentIndex > totalPages) {
      return 100.0;
    }
    return (currentIndex / totalPages) * Get.width;
  }

  double calculateProgress2(
      int currentDay, int daysUntilEvent, double totalWidth) {
    // Assuming currentDay is the day of the month and daysUntilEvent is the total days remaining until the event
    double progressFraction = currentDay / (currentDay + daysUntilEvent);
    return progressFraction *
        totalWidth; // Calculate the proportional width based on progress
  }

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

  Future<void> loadQuran() async {
    String jsonString = await rootBundle.loadString("assets/data/quranV2.json");
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> surahsJson = jsonResponse['data']['surahs'];
    surahs = surahsJson.map((e) => SurahModel.fromMap(e)).toList();

    for (var surah in surahs) {
      allAyas.addAll(surah.ayas);
      // log('Added ${surah.nameOfSurah} ayahs');
    }
    update();
    List.generate(
      604,
      (pageIndex) {
        pages.add(allAyas.where((ayah) => ayah.page == pageIndex + 1).toList());
      },
    );
    // log('Pages Length: ${pages.length}', name: 'Quran Controller');
  }

  Future<void> loadQuranSurahsInfo() async {
    String jsonString =
        await rootBundle.loadString("assets/data/sura_info.json");
    List<dynamic> jsonResponse = jsonDecode(jsonString);

    for (var surah in jsonResponse) {
      suarhsInfo.add(SurahInfoModel.fromMap(surah));
    }
    update();
  }

  Future<void> loadAllahNames() async {
    String jsonString = await rootBundle.loadString("assets/data/names.json");
    var jsonResponse = jsonDecode(jsonString);

    for (var name in jsonResponse['names']) {
      allahNames.add(AllahNameModel.fromMap(name));
      // log(name["name"]);
    }
    update();
  }

  List<List<AyaOfSurahModel>> getCurrentPageAyahsSeparatedForBasmala(
          int pageIndex) =>
      pages[pageIndex]
          .splitBetween((f, s) => f.numberOfAyaInSurah > s.numberOfAyaInSurah)
          .toList();

  List<AyaOfSurahModel> getCurrentPageAyas(int pageIndex) => pages[pageIndex];

  int getSurahNumberFromPage(int pageNumber) {
    log("Gets Sura Number from page $pageNumber");
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

  Future<void> getAyaTafser() async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
      return;
    }
    List results = (await database.query("saadi",
            columns: [
              '"index"',
              'sura',
              'aya',
              'text',
              'pageNum',
            ],
            // where: "PageNum=$page",
            orderBy: '"index"'))
        .cast<Map>();
    // tafserOfPage = [];
    mapOfTafser.clear();
    for (var element in results) {
      mapOfTafser.addAll({element['index']: element['text']});
      // tafserOfPage.add(element['text']);
    }
    log('Tafser leanth======${mapOfTafser.length}');
    // refresh();
  }

  List<SurahModel> surasFoundbySearch = [];
  void searchForAyas(String searchText) {
    try {
      ayasFoundBySearch.clear();
      surasFoundbySearch.clear();
      log("Start Searching for $searchText");
      if (searchText.isEmpty) {
        ayasFoundBySearch.clear();
        surasFoundbySearch.clear();
        refresh();
        return;
      }
      var results =
          allAyas.where((aya) => aya.searchTextOfAya.contains(searchText));
      for (var aya in results) {
        ayasFoundBySearch.add(aya);
      }
      var surasResults = surahs.where((sura) =>
          removeDiacritics(sura.nameOfSurah).substring(5).contains(searchText));
      for (var element in surasResults) {
        surasFoundbySearch.add(element);
      }
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
