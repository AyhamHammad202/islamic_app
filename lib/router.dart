import 'package:flutter/material.dart';
import 'package:islamic_app/views/home_view.dart';
import 'package:islamic_app/views/sura_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.id:
      return MaterialPageRoute(
        builder: (context) => HomeView(),
      );
    case SuraView.id:
      return MaterialPageRoute(
        builder: (context) => SuraView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Text("DEFAULT ROUTE ERROR"),
      );
  }
}
