import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/zekr_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

import '../database/data_client.dart';

class AzkarController extends GetxController {
  final DataClient _dataClient = DataClient();
  List<ZekrModel> azkar = [];
  List<ZekrModel> filterdAzkar = [];
  List<String> categories = [];

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
    }
    getAllAzkarCategories();
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

  void getAllAzkarCategories() {
    categories.assignAll(azkar.map((e) => e.category).toSet().toList());
  }

  void getFilterdAzkar(String category) async {
    filterdAzkar.clear();
    filterdAzkar.addAll(
      azkar.where((z) => z.category == category),
    );
  }

  Future shareZkar(ZekrModel zekrModel, BuildContext context) async {
    try {
      await Share.share(zekrModel.zekr);
    } on Exception {
      if (context.mounted) {
        show(context: context, message: "حدث خطأ");
      }
    }
  }

  Future copyZkar(ZekrModel zekrModel, BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: zekrModel.zekr));
    } on Exception {
      if (context.mounted) {
        show(context: context, message: "حدث خطأ");
      }
    }
  }
}
