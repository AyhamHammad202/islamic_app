import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/aya_model.dart';
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

  List<AyatModel>? ayatOfPage;
  void getAllAyatOfPage(int page) async {
    log("getting data ishuhhsfufhasu");
    ayatOfPage = [];
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      // return [];
    }
    try {
      List<Map> results = (await database!.query(AyatModel.tableName,
              columns: AyatModel.columns, where: "PageNum=$page"))
          .cast<Map>();
      results.forEach(
        (element) {
          ayatOfPage!.add(AyatModel.fromMap(element));
        },
      );
      emit(QuranDone());
    } catch (e) {
      log('Database query failed: $e');
    }
  }
}
