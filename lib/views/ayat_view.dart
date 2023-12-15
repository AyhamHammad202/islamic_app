import 'package:flutter/material.dart';

class AyatView extends StatelessWidget {
  const AyatView({super.key});
  static const String id = "Ayat-View";

  @override
  Widget build(BuildContext context) {
    PageController pageController=PageController();
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: 604,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/quran_pages/00${index}.png"),
              Image.asset("assets/images/quran_page