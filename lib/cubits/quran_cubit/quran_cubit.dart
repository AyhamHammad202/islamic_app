import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:islamic_app/database/data_client.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/models/last_read_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/sorah_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  List<SorahModel> allSorahOfQuran = [];
  int lastPageRead = 1;

  void setLastRead(int page) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("lastRead", page);
  }

  Future<int> getFLastRead() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("lastRead")??1;
  }

  void getLastRead() async {
    emit(LastRead());
    lastPageRead = await getFLastRead();
  }

  LastReadModel? lastRead;
  void getAyatOfLastRead(int page) async {
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      // return [];
    }
    try {
      var result = await database!.query(
        LastReadModel.table,
        columns: LastReadModel.columns,
        limit: 1,
        where: "PageNum =${lastPageRead}",
      );
      lastRead = LastReadModel.fromMap(result.first);
      emit(QuranDone());
    } catch (e) {
      log('Database query failed: $e');
    }
  }

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

  List<PageModel>? currentPage;
  void getCurrentPageSora(int page) async {
    currentPage = [];
    emit(QuranSearch());
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      print('Database is null or closed');
      // return [];
    }

    try {
      List<Map> results = (await database!.query(
        PageModel.tableName,
        columns: PageModel.columns,
        where: "PageNum =${page}",
      ))
          .cast<Map>();
      results.forEach((result) {
        PageModel pageModel = PageModel.fromMap(result);
        currentPage!.add(pageModel);
      });
      log("pageeeeeeeeeeeeeeeeeeeeeee ${currentPage!.length}");
      log("pageeeeeeeeeeeeeeeeeeeeeee ${currentPage![0].soraNum}");
      emit(QuranDone());
    } catch (e) {
      log('Database query failed: $e');
    }
  }

  List<AyatModel>? ayatOfPage;
  void getAllAyatOfPage(int page) async {
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

  List<AyatModel>? ayaList = [];
  void search(String text) async {
    ayaList!.clear();
    emit(QuranSearch());
    Database? database = await _client.database;
    if (database == null || !database.isOpen) {
      log('Database is null or closed');
    }
    try {
      if (text.isNotEmpty) {
        await database!.transaction(
          (transaction) async {
            List<Map> results = await transaction.query(
              AyatModel.tableName,
              columns: AyatModel.columns,
              where: "SearchText LIKE ? OR PageNum = ? OR SoraNameSearch = ?",
              whereArgs: ['%$text%', text, text],
            );
            results.forEach(
              (aya) {
                ayaList!.add(AyatModel.fromMap(aya));
              },
            );
            log("${ayaList!.length}");
          },
        );
        log("searchhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${ayaList!.length}");
      }

      emit(QuranDone());
    } catch (e) {
      log("Error in search: $e");
    }
  }
}
