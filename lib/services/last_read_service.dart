import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadService extends GetxService {
  late SharedPreferences sharedPrefs;

  RxInt lastPageRead = 1.obs;
  RxString lastDateRead = "${DateTime.now()}".obs;
  RxInt lastSuraNumRead = 1.obs;
  RxInt lastAyaNumRead = 1.obs;
  void setLastRead(int page, String date, int suraNum, int ayaNum) {
    lastPageRead.value = page;
    lastDateRead.value = date;
    lastSuraNumRead.value = suraNum;
    lastAyaNumRead.value = ayaNum;
    sharedPrefs.setInt("lastRead", page);
    sharedPrefs.setString("lastDateRead", date);
    sharedPrefs.setInt("lastSuraNumRead", suraNum);
    sharedPrefs.setInt("lastAyaNumRead", ayaNum);
  }

  Future<LastReadService> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    lastPageRead.value = sharedPrefs.getInt("lastRead") ?? 1;
    lastDateRead.value =
        sharedPrefs.getString("lastDateRead") ?? "${DateTime.now()}";
    lastSuraNumRead.value = sharedPrefs.getInt("lastSuraNumRead") ?? 1;
    lastAyaNumRead.value = sharedPrefs.getInt("lastAyaNumRead") ?? 1;
    return this;
  }
}
