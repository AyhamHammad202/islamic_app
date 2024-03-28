import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  late SharedPreferences sharedPreferences;

  RxInt ayaFontSize = 24.obs;
  RxInt ayaTafserFontSize = 16.obs;
  RxBool salatAldohaReminder = false.obs;
  RxBool salatAlotrReminder = false.obs;
  RxInt currentReaderIndex = 0.obs;

  void setReaderIndex(int index) {
    currentReaderIndex.value = index;
    sharedPreferences.setInt(Constant.currentReaderKey, index);
  }

  void setAyaFontSize(int size) {
    ayaFontSize.value = size;
    sharedPreferences.setInt(kSettingAyaFontSizeKey, size);
  }

  void setAyaTafserFontSize(int size) {
    ayaTafserFontSize.value = size;
    sharedPreferences.setInt(kSettingAyaTafserFontSizeKey, size);
  }

  void setSalatAldohaReminder(bool isEnabled) {
    salatAldohaReminder.value = isEnabled;
    sharedPreferences.setBool(kSettingSalatAldohaKey, isEnabled);
  }

  void setSalatAlotrReminder(bool isEnabled) {
    salatAlotrReminder.value = isEnabled;
    sharedPreferences.setBool(kSettingSalatAlotrKey, isEnabled);
  }

  Future<SettingsService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    currentReaderIndex.value =
        sharedPreferences.getInt(Constant.currentReaderKey) ?? 0;
    ayaFontSize.value = sharedPreferences.getInt(kSettingAyaFontSizeKey) ?? 24;
    ayaTafserFontSize.value =
        sharedPreferences.getInt(kSettingAyaTafserFontSizeKey) ?? 16;
    salatAldohaReminder.value =
        sharedPreferences.getBool(kSettingSalatAldohaKey) ?? false;
    salatAlotrReminder.value =
        sharedPreferences.getBool(kSettingSalatAlotrKey) ?? false;
    return this;
  }
}
