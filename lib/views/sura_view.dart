// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:islamic_app/models/sura_model.dart';
import 'package:islamic_app/views/widgets/sura_view_body.dart';

class SuraView extends StatelessWidget {
  const SuraView({
    Key? key,
    required this.sura,
  }) : super(key: key);
  static const String id = "sura-view";
  final SuraModel sura;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SuraViewBody(sura: sura),
      ),
    );
  }
}
