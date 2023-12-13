import 'package:flutter/material.dart';
import 'package:islamic_app/views/home_view.dart';
import 'package:islamic_app/views/sura_view.dart';

import 'models/sura_model.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.id:
      return MaterialPageRoute(
        builder: (context) => HomeView(),
      );
    case SuraView.id:
      final SuraModel sura = settings.arguments as SuraModel;
      return MaterialPageRoute(
        builder: (context) => SuraView(
          sura: sura,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Text("DEFAULT ROUTE ERROR"),
      );
  }
}
