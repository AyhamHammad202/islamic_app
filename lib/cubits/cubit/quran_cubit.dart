import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/models/sura_model.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/sorah_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  DataClient _client = DataClient();
  Future<List<SorahModel>> all() async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      return [];
    }

    try {
      List<Map> results = (await database.query(SorahModel.tableName,
              columns: SorahModel.columns))
          .cast<Map>();

      List<SorahModel> sorahList = [];
      results.forEach((result) {
        log(result.toString());
        SorahModel suraModel = SorahModel.fromMap(result);
        sorahList.add(suraModel);
      });
      log("HEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
      return sorahList;
    } catch (e) {
      log('Database query failed: $e');
      return [];
    }
  }

  List<SuraModel> suras = [];
  List<AyaModel>? allAyaOfSura;

  void getAllSuraOfQuran() async {
    final String response = await rootBundle.loadString(suraJsonFile);
    dynamic surasData = jsonDecode(response);
    for (var sura in surasData) {
      SuraModel s = SuraModel.fromMap(sura);
      suras.add(s);
      // for (var aya in s.allAya) {
      //   AyaModel ayaModel = AyaModel.fromMap(s.allAya[0]);
      //   allAyaOfSura.add(ayaModel);
      // }
    }
    log(suras[0].titleAr);
    log(suras[1].titleAr);
    emit(QuranDone());
  }

  void getAllAyaOfSura(SuraModel sura) async {
    allAyaOfSura = [];
    for (var aya in sura.allAya) {
      AyaModel ayaModel = AyaModel.fromMap(aya);
      allAyaOfSura!.add(ayaModel);
    }
    log("${allAyaOfSura.toString()} ${allAyaOfSura!.length}");
  }
}
