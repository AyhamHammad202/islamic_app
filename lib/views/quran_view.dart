import 'package:flutter/material.dart';

import 'widgets/quran_view_body.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});
  static const String id = "Quran-View";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QuranViewBody(),
    );
  }
}
