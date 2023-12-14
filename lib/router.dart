import 'package:flutter/material.dart';
import 'package:islamic_app/views/quran_view.dart';

import 'models/sura_model.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case QuranView.id:
      return MaterialPageRoute(
        builder: (context) => QuranView(),
      );
    // case SuraView.id:
    //   final SuraModel sura = settings.arguments as SuraModel;
    //   return MaterialPageRoute(
    //     builder: (context) => SuraView(
    //       sura: sura,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        builder: (context) => Text("DEFAULT ROUTE ERROR"),
      );
  }
}
