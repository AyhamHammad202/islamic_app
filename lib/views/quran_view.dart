import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:islamic_app/constant.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/quran_view_body.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});
  static const String id = "Quran-View";

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      rtlOpening: true,
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: CustomAppBar(
          advancedDrawerController: _advancedDrawerController,
        ),
        body: QuranViewBody(),
        // drawer: Container(
        //   decoration: BoxDecoration(color: kPrimaryColor),
        //   child: ListView(
        //     children: [
        //       Text("Heeee"),
        //       Text("Hoooo"),
        //     ],
        //   ),
        // ),
      ),
      drawer: Container(),
    );
  }
}
