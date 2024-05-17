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
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReadersController extends GetxController {
  // final QuranController _quranController = Get.find();
  final SettingsService _settingsService = Get.find();
  // final AudioController _audioController = Get.find();
  List<ReaderModel> readers = [];
  final Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  RxBool isDownloading = false.obs;
  RxBool isCanceled = false.obs;
  RxDouble downloadingProgress = 0.0.obs;
  RxInt downloadedAyatCount = 0.obs;
  RxMap<String, bool> suraDownloadStatus = <String, bool>{}.obs;
  late Directory appPath;

  @override
  onInit() async {
    appPath = await getApplicationDocumentsDirectory();
    await loadReaders();
    super.onInit();
  }

  ReaderModel get currentReader =>
      readers[_settingsService.currentReaderIndex.value];

  Future<void> loadReaders() async {
    String jsonString = await rootBundle.loadString("assets/data/readers.json");
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> radioesJson = jsonResponse['data'];
    readers = radioesJson
        .map(
          (e) => ReaderModel.fromMap(e),
        )
        .toList();
    update();
  }

  Future<bool> isAyaDownloaded(File aya, ReaderModel readerModel) async {
    try {
      if (await aya.exists()) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> isSuraDownloaded(
      SurahModel sura, ReaderModel readerModel) async {
    try {
      for (var aya in sura.ayas) {
        bool isDownloaded = await isAyaDownloaded(
            File(
                "${appPath.path}/reader/${readerModel.link}/${sura.englishNameOfSurah}/${aya.numberOfAyaInSurah}.mp3"),
            readerModel);
        if (!isDownloaded) {
          return false; // return false as soon as one Aya is not downloaded
        }
      }
      return true; // return true only if all Ayas are downloaded
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void checkIfSuraDownloaded(SurahModel sura, ReaderModel readerModel) async {
    bool isDownloaded = await isSuraDownloaded(sura, readerModel);
    String key = '${sura.englishNameOfSurah}-${readerModel.englishName}';
    suraDownloadStatus[key] = isDownloaded;
  }

  Future downloadAya(File file, AyaOfSurahModel aya, SurahModel surah,
      ReaderModel readerModel) async {
    try {
      log(file.path);
      if (!await file.exists()) {
        isDownloading.value = true;
        var donwloadUrl =
            "https://everyayah.com/data/${readerModel.link}/${surah.numberOfSurah.toString().padLeft(3, "0")}${aya.numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3";
        await dio.download(
          donwloadUrl,
          file.path,
          cancelToken: cancelToken,
          onReceiveProgress: (received, total) async {
            if (total <= 0) return;
            downloadingProgress.value = (received / total * 100);
          },
        );
        downloadedAyatCount.value++;
        isDownloading.value = false;
        downloadingProgress.value = 0.0;
      } else {
        log("Aya Already downloaded");
        downloadedAyatCount.value++;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        isDownloading.value = false;
        log("cancled download");
        isCanceled.value = true;
        return;
      }
    } catch (e) {
      isDownloading.value = false;
      return e;
    }
  }

  Future downloadSuraAyas(SurahModel surah, ReaderModel readerModel) async {
    try {
      log(readerModel.englishName);
      cancelToken = CancelToken();
      downloadedAyatCount = 0.obs;
      isCanceled = false.obs;

      for (var aya in surah.ayas) {
        await downloadAya(
          File(
              "${appPath.path}/reader/${readerModel.link}/${surah.englishNameOfSurah}/${aya.numberOfAyaInSurah}.mp3"),
          aya,
          surah,
          readerModel,
        );
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            notificationLayout: NotificationLayout.ProgressBar,
            id: 10,
            channelKey: 'progress_bar',
            title: S.current.download,
            body:
                'Downloading ${surah.englishNameOfSurah}:${(downloadedAyatCount.value / surah.ayas.length * 100).toInt()}%',
            progress:
                (downloadedAyatCount.value / surah.ayas.length * 100).toInt(),
            locked: isDownloading.value,
          ),
        );
        log("downloaded aya ${aya.numberOfAyaInSurah}");
        if (isCanceled.value) {
          return;
        }
      }
      checkIfSuraDownloaded(surah, readerModel);
    } catch (e) {
      return e;
    }
  }

  Future<void> shareAudio(
    AudioController audioController,
    ReadersController readersController,
    AyaOfSurahModel aya,
    SurahModel surah,
  ) async {
    audioController.ayaUniqeId.value = aya.uniqueIdOfAya;
    final file = File(audioController.ayaPath);
    if (!await file.exists()) {
      await readersController.downloadAya(
          file, aya, surah, audioController.currentReader);
    }
    await Share.shareXFiles([
      XFile(file.path,
          name: '${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}'),
    ],
        text:
            '${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}z\n${S.current.sharedBy}');
  }

  void shareText(AyaOfSurahModel aya, SurahModel surah) {
    Share.share(
        '﴿${aya.textOfAya}﴾ [${surah.nameOfSurah}-${aya.numberOfAyaInSurah.toArabic()}]\n${S.current.sharedBy}');
  }
}
