import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_library/quran.dart';
import 'package:share_plus/share_plus.dart';

class ReadersController extends GetxController {
  final SettingsService _settingsService = Get.find();
  final Dio dio = Dio();

  final RxBool isDownloading = false.obs;
  final RxBool isCanceled = false.obs;
  final RxDouble downloadingProgress = 0.0.obs;
  final RxInt downloadedAyatCount = 0.obs;
  final RxMap<String, bool> suraDownloadStatus = <String, bool>{}.obs;

  late Directory appPath;
  late CancelToken cancelToken;
  List<ReaderModel> readers = [];

  ReaderModel get currentReader =>
      readers[_settingsService.currentReaderIndex.value];

  @override
  Future<void> onInit() async {
    super.onInit();
    appPath = await getApplicationDocumentsDirectory();
    await loadReaders();
  }

  Future<void> loadReaders() async {
    final jsonString = await rootBundle.loadString("assets/data/readers.json");
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    final List<dynamic> readersJson = jsonResponse['data'];
    readers = readersJson.map((e) => ReaderModel.fromMap(e)).toList();
    update();
  }

  Future<bool> isAyaDownloaded(File file) async {
    try {
      return await file.exists();
    } catch (e) {
      log("Error checking file existence: $e");
      return false;
    }
  }

  Future<bool> isSuraDownloaded(SurahModel sura, ReaderModel reader) async {
    for (var aya in sura.ayahs) {
      final file = _getAyaFile(reader, sura, aya);
      if (!await isAyaDownloaded(file)) return false;
    }
    return true;
  }

  void checkIfSuraDownloaded(SurahModel sura, ReaderModel reader) async {
    final key = '${sura.englishName}-${reader.englishName}';
    suraDownloadStatus[key] = await isSuraDownloaded(sura, reader);
  }

  Future<void> downloadAya(
      File file, AyahModel aya, SurahModel surah, ReaderModel reader) async {
    try {
      if (await file.exists()) {
        downloadedAyatCount.value++;
        return;
      }

      isDownloading.value = true;

      final downloadUrl =
          "https://everyayah.com/data/${reader.link}/${surah.surahNumber.toString().padLeft(3, "0")}${aya.ayahNumber.toString().padLeft(3, "0")}.mp3";

      await dio.download(
        downloadUrl,
        file.path,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            downloadingProgress.value = (received / total) * 100;
          }
        },
      );

      downloadedAyatCount.value++;
      downloadingProgress.value = 0.0;
      isDownloading.value = false;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        isDownloading.value = false;
        isCanceled.value = true;
        log("Download cancelled");
      }
    } catch (e) {
      isDownloading.value = false;
      log("Error downloading ayah: $e");
    }
  }

  Future<void> downloadSuraAyas(SurahModel surah, ReaderModel reader) async {
    cancelToken = CancelToken();
    isCanceled.value = false;
    downloadedAyatCount.value = 0;

    for (var aya in surah.ayahs) {
      final file = _getAyaFile(reader, surah, aya);
      await downloadAya(file, aya, surah, reader);

      if (isCanceled.value) break;

      final progress = (downloadedAyatCount.value / surah.ayahs.length) * 100;

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          notificationLayout: NotificationLayout.ProgressBar,
          id: 10,
          channelKey: 'progress_bar',
          title: S.current.download,
          body:
              '${Get.locale.toString() == "en" ? surah.englishName : surah.arabicName}: ${S.current.downloadAyat} ${progress.toInt()}%',
          progress: progress,
          locked: isDownloading.value,
        ),
      );
    }

    checkIfSuraDownloaded(surah, reader);
  }

  Future<void> shareAudio(
    AudioController audioController,
    AyahModel aya,
    SurahModel surah,
  ) async {
    audioController.ayaUniqeId.value = aya.ayahUQNumber;
    final file = File(audioController.ayaPath);

    if (!await file.exists()) {
      await downloadAya(file, aya, surah, audioController.currentReader);
    }

    await Share.shareXFiles(
      [
        XFile(file.path,
            name: '${surah.arabicName}-${aya.ayahNumber.toArabic()}'),
      ],
      text:
          '${surah.arabicName}-${aya.ayahNumber.toArabic()}\n${S.current.sharedBy}',
    );
  }

  void shareText(AyahModel aya, SurahModel surah) {
    Share.share(
      '﴿${aya.ayaTextEmlaey}﴾ [${surah.arabicName}-${aya.ayahNumber.toArabic()}]\n${S.current.sharedBy}',
    );
  }

  File _getAyaFile(ReaderModel reader, SurahModel surah, AyahModel aya) {
    return File(
      "${appPath.path}/reader/${reader.link}/${surah.englishName}/${aya.ayahNumber}.mp3",
    );
  }
}
