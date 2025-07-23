// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/views/bookmark/bookmark_view.dart';
import 'package:islamic_app/views/home/home_view.dart';
import 'package:islamic_app/views/more_view/more_view.dart';
import 'package:islamic_app/views/quran/quran_view.dart';

class GeneralController extends GetxController {
  List<Widget> homeNavViews = const [
    HomeView(),
    QuranView(),
    BookmarkView(),
    MoreView(),
  ];
  PageController pageController = PageController();
  TextEditingController searchController = TextEditingController();
  RxString searchText = "".obs;
  RxInt tabSelected = 0.obs;
  RxInt navItemSelected = 0.obs;
}
