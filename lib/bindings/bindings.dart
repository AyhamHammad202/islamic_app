import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/controllers/azkar_controller.dart';
import 'package:islamic_app/controllers/bookmark_controller.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/controllers/mesbaha_controller.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(() => QuranController());
    Get.lazyPut(() => BookMarkController(), fenix: true);
    Get.lazyPut(() => MesbahaController(), fenix: true);
    Get.lazyPut(() => GeneralController(), fenix: true);
    Get.lazyPut(() => AzkarController(), fenix: true);
    Get.lazyPut(() => AudioController(), fenix: true);
  }
}
