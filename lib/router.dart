import 'package:flutter/material.dart';
import 'package:islamic_app/views/home_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.id:
      return MaterialPageRoute(builder: (context) => HomeView());
    default:
      return MaterialPageRoute(
          builder: (context) => Text("DEFAULT ROUTE ERROR"));
  }
}
