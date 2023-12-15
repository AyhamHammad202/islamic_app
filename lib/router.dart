import 'package:flutter/material.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/views/ayat_view.dart';
import 'package:islamic_app/views/quran_view.dart';


Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuranView.id:
      return MaterialPageRoute(
        builder: (context) => QuranView(),
      );
    case AyatView.id:
      return MaterialPageRoute(
        builder: (context) => AyatView(  ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Text("DEFAULT ROUTE ERROR"),
      );
  }
}
