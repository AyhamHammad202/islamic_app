import 'dart:developer';

import 'package:get/get.dart';
import 'package:islamic_app/models/zekr_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/data_client.dart';

class AzkarController extends GetxController {
  final DataClient _dataClient = DataClient();
  List<ZekrModel> azkar = [];

  @override
  void onInit() async {
    await getAllTheAzkar();
    super.onInit();
  }

  Future getAllTheAzkar() async {
    Database? database = await _dataClient.database;
    if (database == null || !database.isOpen) {
      log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
      return;
    }
    azkar.clear();
    var results = await database.query(ZekrModel.table,
        columns: ZekrModel.columns, where: "isDeleted = 0");
    for (var zekr in results) {
      azkar.add(ZekrModel.fromMap(zekr));
      log("ZEKR ${zekr['id']}");
    }
    refresh();
  }

  Future updateZekr(String newZekr, ZekrModel zekrModel) async {
    Database? database = await _dataClient.database;
    if (database == null || !database.isOpen) {
      log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
      return;
    }
    await database.update(
      ZekrModel.table,
      {'zekr': newZekr},
      where: 'id=${zekrModel.id}',
    );
    await getAllTheAzkar();
    refresh();
  }

  Future deleteZekr(ZekrModel zekrModel) async {
    Database? database = await _dataClient.database;
    if (database == null || !database.isOpen) {
      log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
      return;
    }
    await database.update(
      ZekrModel.table,
      {'isDeleted': 1},
      where: 'id=${zekrModel.id}',
    );
    await getAllTheAzkar();
    refresh();
  }

  Future resetAllAzkar() async {
    Database? database = await _dataClient.database;
    if (database == null || !database.isOpen) {
      log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
      return;
    }
    await database.rawUpdate(
        "UPDATE ${ZekrModel.table} SET zekr=defaultZekr,isDeleted=0");
    await getAllTheAzkar();
    refresh();
  }

  Future resetOneZekr(ZekrModel zekrModel) async {
    Database? database = await _dataClient.database;
    if (database == null || !database.isOpen) {
      log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
      return;
    }
    await database.rawUpdate(
        "UPDATE ${ZekrModel.table} SET zekr=defaultZekr,isDeleted=0 WHERE id=${zekrModel.id}");
    await getAllTheAzkar();
    refresh();
  }
}
