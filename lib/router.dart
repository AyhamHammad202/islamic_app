import 'package:flutter/material.dart';
import 'package:islamic_app/models/sorah_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/views/about_us_view.dart';
import 'package:islamic_app/views/ayat_view.dart';
import 'package:islamic_app/views/quran_view.dart';
import 'package:islamic_app/views/search_view.dart';
import 'package:islamic_app/views/settings_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuranView.id:
      return MaterialPageRoute(
        builder: (context) => QuranView(),
      );
    case SettingsView.id:
      return MaterialPageRoute(
        builder: (context) => SettingsView(),
      );
    case AboutUsView.id:
      return MaterialPageRoute(
        builder: (context) => AboutUsView(),
      );
    case AyatView.id:
      return MaterialPageRoute(
        builder: (context) => AyatView(
          sorah: settings.arguments as SurahModel,
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
