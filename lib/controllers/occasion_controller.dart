import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/helper.dart';

class OccasionController extends GetxController {

  // List<AyaOfSurahModel> allAyas = [];

  List<String> tables = [];

  Map<int, String> mapOfTafser = {};

  late AdvancedDrawerController advancedDrawerController;
  late ScrollController homePageScrollerController;

  @override
  void onInit() async {
    super.onInit();
    advancedDrawerController = AdvancedDrawerController();
    homePageScrollerController = ScrollController();

    // await getAyaTafser();
  }

  @override
  void onClose() {
    log("onClose method called");
    advancedDrawerController.dispose();
    super.onClose();
  }

  int calculate(int year, int month, int day) {
    HijriCalendar hijriCalendar = HijriCalendar();
    DateTime start = DateTime.now();
    DateTime end = hijriCalendar.hijriToGregorian(year, month, day);

    if (!start.isAfter(end)) {
      return DateTimeRange(start: start, end: end).duration.inDays;
    } else {
      return 0;
    }
  }

  double calculateProgress(int currentIndex, int total) {
    int totalPages = total;
    if (currentIndex < 1) return 0.0;
    if (currentIndex > totalPages) return 100.0;

    return ((currentIndex / totalPages) *
        Get.context!.customOrientation(Get.width * .8, Get.width * .4));
  }
}
