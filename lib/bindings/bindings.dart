import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(() => QuranController());
    Get.lazyPut(() => BookMarkController());
    Get.lazyPut(() => AudioController());
  }
}
