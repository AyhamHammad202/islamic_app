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
  @override
  void onInit() {
    log("SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");

    super.onInit();
  }

  @override
  void onClose() {
    log("SEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    super.onClose();
  }
  // Location location = Location();
  // LocationData? userLocation;

  // @override
  // void onInit() async {
  //   await getUserLocation();

  //   super.onInit();
  // }

  // Future getUserLocation() async {
  //   if (!await location.serviceEnabled()) {
  //     await location.requestService();
  //     if (!await location.serviceEnabled()) {
  //       // Handle the case when location services are not enabled.
  //       return;
  //     }
  //   }
  //   log("HOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
  //   userLocation = await location.getLocation();

  //   if (await location.hasPermission() == PermissionStatus.denied) {
  //     await location.requestPermission();
  //     if (await location.hasPermission() != PermissionStatus.granted) {
  //       // Handle the case when location permissions are not granted.
  //       log("HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  //       userLocation = await location.getLocation();
  //     }
  //   }
  // }
}
