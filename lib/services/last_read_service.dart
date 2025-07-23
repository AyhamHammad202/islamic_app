import 'package:get/get.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:quran_library/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadService extends GetxService {
  late SharedPreferences sharedPrefs;
  final QuranController _quranController = Get.find();

  RxInt lastPageRead = 1.obs;
  RxString lastDateRead = "${DateTime.now()}".obs;
  RxInt lastSuraNumRead = 1.obs;
  RxInt lastAyaNumRead = 1.obs;
  RxInt lastAyaUniqeNumRead = 1.obs;
  void _setLastRead(
      int page, String date, int suraNum, int ayaNum, int uniqeNumOfAya) {
    lastPageRead.value = page;
    lastDateRead.value = date;
    lastSuraNumRead.value = suraNum;
    lastAyaNumRead.value = ayaNum;
    sharedPrefs.setInt("lastRead", page);
    sharedPrefs.setString("lastDateRead", date);
    sharedPrefs.setInt("lastSuraNumRead", suraNum);
    sharedPrefs.setInt("lastAyaNumRead", ayaNum);
    sharedPrefs.setInt("lastAyaUniqeNumRead", uniqeNumOfAya);
  }

  void updateLastRead(AyahModel firstAya) {
    _setLastRead(
      firstAya.page,
      DateTime.now().toString(),
      QuranLibrary()
          .getCurrentSurahDataByPageNumber(pageNumber: firstAya.page)
          .surahNumber,
      _quranController.pages[firstAya.page - 1].first.ayahNumber,
      _quranController.pages[firstAya.page - 1].first.ayahUQNumber,
    );
  }

  Future<LastReadService> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    lastPageRead.value = sharedPrefs.getInt("lastRead") ?? 1;
    lastDateRead.value =
        sharedPrefs.getString("lastDateRead") ?? "${DateTime.now()}";
    lastSuraNumRead.value = sharedPrefs.getInt("lastSuraNumRead") ?? 1;
    lastAyaNumRead.value = sharedPrefs.getInt("lastAyaNumRead") ?? 1;
    lastAyaUniqeNumRead.value = sharedPrefs.getInt("lastAyaUniqeNumRead") ?? 1;
    return this;
  }
}
