import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/models/allah_name_model.dart';
import 'package:islamic_app/models/quran_duaa_model.dart';
import 'package:islamic_app/models/surah_info.dart';
import 'package:quran_library/quran_library.dart';

class QuranController extends GetxController {
  List<SurahModel> surahs = [];
  List<AyahModel> ayas = [];
  List<List<AyahModel>> pages = [];
  List<AyahModel> searchedSurahs = [];
  List<AyahModel> searchedAyas = [];
  RxBool isLoading = false.obs;
  RxBool isClickedOnPage = false.obs;
  PreferDirection preferDirection = PreferDirection.topCenter;
  List<SurahInfoModel> suarhsInfo = [];

  List<AllahNameModel> allahNames = [];
  List<QuranDuaaModel> quranDuaas = [];
  RxInt randomSura = 1.obs;
  RxInt randomAyaFromSura = 1.obs;
  RxInt randomAya = 1.obs;

  @override
  void onInit() async {
    await loadQuran();
    await loadTafser();
    await loadQuranSurahsInfo();
    await quranDuaasNames();
    randomAyaSelect();
    await loadAllahNames();

    super.onInit();
  }

  Future<void> loadQuran() async {
    surahs = QuranLibrary().quranCtrl.state.surahs;
    ayas = QuranLibrary().quranCtrl.state.allAyahs;
    pages = QuranLibrary().quranCtrl.state.pages;
    log(surahs.length.toString());
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

  Future<void> search(String text) async {
    searchAyahs(text);
    surahSearchMethod(text);
    log("SEarchedSURAS =${searchedSurahs.length}");
    update();
  }

  void searchAyahs(String text) async {
    if (text.trim().isEmpty) {
      log("Empty search query, skipping search.");
      searchedAyas.clear();
      update();
      return;
    }

    searchedAyas.clear();
    _setLoading(true);

    try {
      final values = QuranLibrary().search(text.toArabic());
      if (values.isNotEmpty) {
        searchedAyas.assignAll(values);
        _setLoading(false);
        update();
      } else {
        _setLoading(false);
        update();
      }
    } catch (e) {
      _setLoading(false);
      update();
    }
  }

  void surahSearchMethod(String text) async {
    searchedSurahs.clear();
    _setLoading(true);
    update();
    try {
      final values = QuranLibrary().surahSearch(text);
      if (values.isNotEmpty) {
        // Use a map to track unique Surahs
        var uniqueSurahs = <int, AyahModel>{};
        for (var aya in values) {
          if (!uniqueSurahs.containsKey(aya.surahNumber)) {
            uniqueSurahs[aya.surahNumber!] = aya;
          }
        }
        searchedSurahs.assignAll(uniqueSurahs.values);
        _setLoading(false);
        update();
      } else {
        searchedSurahs.clear();
        _setLoading(false);
        update();
      }
    } catch (e) {
      searchedSurahs.clear();
      _setLoading(false);
      update();
    }
  }

  Future<void> quranDuaasNames() async {
    String jsonString =
        await rootBundle.loadString("assets/data/quran_duaa.json");
    var jsonResponse = jsonDecode(jsonString);

    for (var name in jsonResponse['surahs']) {
      quranDuaas.add(QuranDuaaModel.fromMap(name));
    }

    randomDuaa();
    update();
  }

  void randomDuaa() {
    randomSura = math.Random().nextInt(quranDuaas.length - 1).obs;
    randomAyaFromSura =
        math.Random().nextInt(quranDuaas[randomSura.value].ayas.length).obs;
    log("Random Duaa Selected");
    update();
  }

  void randomAyaSelect() {
    randomAya = math.Random().nextInt(ayas.length).obs;
    log("Random Aya Selected");
    update();
  }

  Future<void> loadAllahNames() async {
    String jsonString = await rootBundle.loadString("assets/data/names.json");
    var jsonResponse = jsonDecode(jsonString);

    for (var name in jsonResponse['names']) {
      allahNames.add(AllahNameModel.fromMap(name));
    }

    update();
  }

  Future<void> loadTafser() async {
    await QuranLibrary().initTafsir();
  }
  // TafsirTableData getAyaTafsir(AyahModel aya) async  {
  //   tafsir =await QuranLibrary().getTafsirOfAyah(ayahUniqNumber: aya.ayahUQNumber);
  // }

  void _setLoading(bool value) {
    isLoading.value = value;
  }
}
