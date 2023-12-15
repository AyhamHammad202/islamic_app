import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/sorah_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  List<SorahModel> allSorahOfQuran = [];

  DataClient _client = DataClient();
  void all() async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      // return [];
    }

    try {
      List<Map> results = (await database!
              .query(SorahModel.tableName, columns: SorahModel.columns))
          .cast<Map>();
      results.forEach((result) {
        SorahModel suraModel = SorahModel.fromMap(result);
        allSorahOfQuran.add(suraModel);
      });
      emit(QuranDone());
    } catch (e) {
      log('Database query failed: $e');
    }
  }

  // List<SuraModel> suras = [];
  // List<AyaModel>? allAyaOfSura;

  // void getAllSuraOfQuran() async {
  //   final String response = await rootBundle.loadString(suraJsonFile);
  //   dynamic surasData = jsonDecode(response);
  //   for (var sura in surasData) {
  //     SuraModel s = SuraModel.fromMap(sura);
  //     suras.add(s);
  //     // for (var aya in s.allAya) {
  //     //   AyaModel ayaModel = AyaModel.fromMap(s.allAya[0]);
  //     //   allAyaOfSura.add(ayaModel);
  //     // }
  //   }
  //   log(suras[0].titleAr);
  //   log(suras[1].titleAr);
  //   emit(QuranDone());
  // }

  // void getAllAyaOfSura(SuraModel sura) async {
  //   allAyaOfSura = [];
  //   for (var aya in sura.allAya) {
  //     AyaModel ayaModel = AyaModel.fromMap(aya);
  //     allAyaOfSura!.add(ayaModel);
  //   }
  //   log("${allAyaOfSura.toString()} ${allAyaOfSura!.length}");
  // }
}
