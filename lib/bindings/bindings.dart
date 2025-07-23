import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/controllers/occasion_controller.dart';
import 'package:islamic_app/controllers/radio_controller.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/controllers/update_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    await Get.putAsync(() async => QuranController());
    await Get.putAsync<OccasionController>(() async => OccasionController());
    await Get.putAsync(() async => ReadersController());
    await Get.putAsync(() async => AudioController());
    await Get.putAsync(() async => UpdateController());
    await Get.putAsync(() async => BookMarkController());
    await Get.putAsync(() async => MesbahaController());
    await Get.putAsync(() async => AzkarController());
    await Get.putAsync(() async => RadioController());
  }
}
