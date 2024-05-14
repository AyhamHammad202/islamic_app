import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/services/settings_service.dart';

class AudioController extends GetxController {
  final SettingsService _settingsService = Get.find();
  final LastReadService _lastReadService = Get.find();
  late final Directory appPath;
  AudioPlayer audioPlayer = AudioPlayer();
  final QuranController _quranController = Get.find<QuranController>();
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  RxBool isDownloading = false.obs;
  RxDouble downloadingProgress = 0.0.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> currentDuration = Duration.zero.obs;
  RxInt ayaUniqeId = 1.obs;
  File? currentAyaPath;
  // RxInt currentReaderIndex = 0.obs;
  Dio dio = Dio();

  @override
  void onClose() async {
    await audioPlayer.pause();
    _quranController.selectedAyahIndexes.clear();
    super.onClose();
  }

  @override
  void onInit() async {
    ayaUniqeId.value = _lastReadService.lastAyaUniqeNumRead.value;
    appPath = await getApplicationDocumentsDirectory();
    await initAudioPlayerStateStream();
    super.onInit();
  }

  AyaOfSurahModel get currentAya =>
      _quranController.allAyas[ayaUniqeId.value - 1];
  SurahModel get currentSura => _quranController
      .surahs[_quranController.getSurahNumberByAya(currentAya) - 1];
  String get currentReaderUrl =>
      Constant.readersLinks[_settingsService.currentReaderIndex.value];
  String get currentReader =>
      Constant.readers[_settingsService.currentReaderIndex.value];

  String get ayaPath =>
      "${appPath.path}/reader/$currentReaderUrl/${currentSura.englishNameOfSurah}/${currentAya.numberOfAyaInSurah}.mp3";
 
  bool get isInDifferentPage =>
      (currentAya.page !=
          _quranController.allAyas[ayaUniqeId.value - 2].page) ||
      (currentAya.page != _quranController.allAyas[ayaUniqeId.value].page);

  // File get ayaFile=>

  Future peauseAyaFile() async {
    if (isPlaying.value || isLoading.value) {
      await audioPlayer.pause();
      _quranController.clearSelection();
      // audioPlayer = AudioPlayer();
      isPlaying.value = false;
      isLoading.value = false;

      return;
    }
  }

  Future initAudioPlayerStateStream() async {
    audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.playing) {
        isPlaying.value = true;
        isLoading.value = false;
        duration.value = audioPlayer.duration ?? Duration.zero;
        audioPlayer.positionStream.listen((position) {
          currentDuration.value = position;
        });
      }

      if (playerState.processingState == ProcessingState.loading) {
        isLoading.value = true;
        isPlaying.value = false;
        // currentDuration.value = Duration.zero;
      }
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying.value = false;
        _quranController.selectedAyahIndexes.clear();
        // currentDuration.value = Duration.zero;
        // duration.value = Duration.zero;
        ayaUniqeId.value = ayaUniqeId.value + 1;
        await playAyah(ayaUniqeId.value);
        // await playNext(ayaOfSurahModel);
      }
    });
    audioPlayer.positionStream.listen((position) {
      currentDuration.value = position;
    });
  }

  Future playAyah(int ayaID) async {
    ayaUniqeId.value = ayaID;
    log(ayaUniqeId.value.toString());
    if (ayaUniqeId.value >= 0 && ayaUniqeId.value < 6236) {
      // var appPath = await getApplicationDocumentsDirectory();
      // var fullPath = "${appPath.path}$ayaPath";
      File file = File(ayaPath);
      if (await file.exists()) {
        log("aya already downloaded and it will play");
        await playAyaFile(file);
      } else {
        log("aya doesnt been downloaded and it will download");
        await downloadAya(file);
        await playAyaFile(file);
      }
    }
  }

  Future playAyaFile(File ayaFile) async {
    try {
      _quranController.clearSelection();
      _quranController.selectedAyahIndexes.add(currentAya.uniqueIdOfAya);
      await audioPlayer.setAudioSource(
        AudioSource.file(
          ayaFile.path,
        ),
      );
      if (isInDifferentPage) {
        _quranController.pageController.animateToPage(
          currentAya.page - 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
      }
      log('Audio player interrupted: $ayaFile');
      await audioPlayer.seek(currentDuration.value);
      await audioPlayer.play();
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }

  Future downloadAya(File file) async {
    try {
      log(file.path);
      if (!await file.exists()) {
        isDownloading.value = true;
        var donwloadUrl =
            "https://everyayah.com/data/$currentReaderUrl/${currentSura.numberOfSurah.toString().padLeft(3, "0")}${currentAya.numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3";

        await dio.download(
          donwloadUrl,
          file.path,
          onReceiveProgress: (received, total) {
            if (total <= 0) return;
            downloadingProgress.value = (received / total * 100);
          },
        );
        isDownloading.value = false;
        downloadingProgress.value = 0.0;
      } else {
        log("Aya Already downloaded");
      }
    } catch (e) {
      return e;
    }
  }
}
