import 'package:flutter/material.dart';
import 'package:islamic_app/models/sorah_model.dart';
import 'package:islamic_app/views/ayat_view.dart';
import 'package:islamic_app/views/quran_view.dart';
import 'package:islamic_app/views/search_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuranView.id:
      return MaterialPageRoute(
        builder: (context) => QuranView(),
      );
    case AyatView.id:
      return MaterialPageRoute(
        builder: (context) => AyatView(
          sorah: settings.arguments as SorahModel,
        ),
      );
    case SearchView.id:
      return MaterialPageRoute(
        builder: (context) => SearchView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Text("DEFAULT ROUTE ERROR"),
      );
  }
}
