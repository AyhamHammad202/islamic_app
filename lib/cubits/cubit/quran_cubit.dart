import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/models/sura_model.dart';
import 'package:meta/meta.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  List<SuraModel> suras = [];
  void getAllSuraOfQuran() async {
    final String response = await rootBundle.loadString(suraJsonFile);
    dynamic surasData = jsonDecode(response);
    for (var sura in surasData) {
      SuraModel s = SuraModel.fromMap(sura);
      suras.add(s);
    }
    log(suras[0].titleAr);
    log(suras[1].titleAr);
    emit(QuranDone());
  }
}
