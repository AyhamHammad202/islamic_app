import 'package:flutter/material.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/version_one_views/about_us_view.dart';
import 'package:islamic_app/version_one_views/ayat_view.dart';
import 'package:islamic_app/version_one_views/quran_view.dart';
import 'package:islamic_app/version_one_views/search_view.dart';
import 'package:islamic_app/version_one_views/settings_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuranView.id:
      return MaterialPageRoute(
        builder: (context) => const QuranView(),
      );
    case SettingsView.id:
      return MaterialPageRoute(
        builder: (context) => const SettingsView(),
      );
    case AboutUsView.id:
      return MaterialPageRoute(
        builder: (context) => const AboutUsView(),
      );
    case AyatView.id:
      return MaterialPageRoute(
        builder: (context) => AyatView(
          sorah: settings.arguments as SurahModel,
        ),
      );
    case SearchView.id:
      return MaterialPageRoute(
        builder: (context) => const SearchView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Text("DEFAULT ROUTE ERROR"),
      );
  }
}
