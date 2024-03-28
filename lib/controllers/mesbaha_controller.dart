// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:get/get.dart';
import 'package:islamic_app/models/tasbeha_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/data_client.dart';

class MesbahaController extends GetxController {
  final DataClient _dataClient = DataClient();
  RxList<TasbehaModel> tasbeh = <TasbehaModel>[].obs;
  RxInt times = 0.obs;

  @override
  void onInit() async {
    await getAllTheTasbeh();
    super.onInit();
  }

  void incretment(int index) {
    if (times.value < tasbeh[index].times) {
      times.value++;
    }
  }

  Future getAllTheTasbeh() async {
    try {
      Database? database = await _dataClient.database;
      if (database == null || !database.isOpen) {
        log("The Database in AZKAR CONTROLLER IS NULL OR CLOSED");
        return;
      }
      tasbeh.clear();
      var results = await database.query(
        'tasbehTable',
        columns: TasbehaModel.columns,
      );
      for (var t in results) {
        tasbeh.add(TasbehaModel.fromMap(t));
      }
      refresh();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
