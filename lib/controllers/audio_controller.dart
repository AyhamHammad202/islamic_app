import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer radioAudioPlayer = AudioPlayer();
  final QuranController _quranController = Get.find<QuranController>();
  RxBool radioIsPlaying = false.obs;
  RxBool radioIsLoading = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> currentDuration = Duration.zero.obs;
  RxInt ayaUniqeId = 0.obs;
  // RxInt currentReaderIndex = 0.obs;
  Dio dio = Dio();

  @override
  void onClose() async {
    await audioPlayer.pause();
    await radioAudioPlayer.pause();
    _quranController.selectedAyahIndexes.clear();
    super.onClose();
  }

  @override
  void onInit() async {
    ayaUniqeId.value = _lastReadService.lastAyaUniqeNumRead.value;
    await initAudioPlayerStateStream();
    super.onInit();
  }

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
      }
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying.value = false;
        _quranController.selectedAyahIndexes.clear();
        ayaUniqeId.value = ayaUniqeId.value + 1;
        await playAyah(ayaUniqeId.value);
        // await playNext(ayaOfSurahModel);
      }
    });
  }

  Future playAyah(int ayaID) async {
    ayaUniqeId.value = ayaID;
    log(ayaUniqeId.value.toString());
    if (ayaUniqeId.value >= 0 && ayaUniqeId.value < 6236) {
      var appPath = await getApplicationDocumentsDirectory();
      var fullPath =
          "${appPath.path}/reader/${Constant.readersNamesDownload[_settingsService.currentReaderIndex.value]}/${_quranController.surahs[_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value]) - 1].englishNameOfSurah}/${_quranController.allAyas[ayaUniqeId.value].numberOfAyaInSurah}";
      File file = File(fullPath);
      if (await file.exists()) {
        log("aya already downloaded and it will play");
        await playAyaFile(file);
      } else {
        log("aya doesnt been downloaded and it will download");
        await downloadAya(file, _quranController.allAyas[ayaUniqeId.value]);
        await playAyaFile(file);
      }
    }
  }

  Future playAyaFile(File ayaFile) async {
    try {
      _quranController.clearSelection();
      _quranController.selectedAyahIndexes.add(ayaUniqeId.value + 1);
      await audioPlayer.setAudioSource(
        AudioSource.file(
          ayaFile.path,
        ),
      );
      if ((_quranController.allAyas[ayaUniqeId.value].page !=
          _quranController.allAyas[ayaUniqeId.value - 1].page)) {
        _quranController.pageController.animateToPage(
          _quranController.allAyas[ayaUniqeId.value - 1].page,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
      }
      await audioPlayer.play();
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }

  Future downloadAya(File file, AyaOfSurahModel aya) async {
    try {
      // var appPath = await getApplicationDocumentsDirectory();
      // var fullPath =
      //     "${appPath.path}/reader${Constant.readers[_settingsService.currentReaderIndex.value]}/${_quranController.surahs[_quranController.getSurahNumberByAya(aya) - 1].englishNameOfSurah}/${aya.numberOfAyaInSurah}";
      // File file = File(fullPath);
      log(file.path);
      if (!await file.exists()) {
        // log("Download aya ${aya.numberOfAyaInSurah}");
        var donwloadUrl =
            "https://everyayah.com/data/${Constant.readersLinks[_settingsService.currentReaderIndex.value]}/${_quranController.getSurahNumberByAya(aya).toString().padLeft(3, "0")}${aya.numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3";

        await dio.download(
          donwloadUrl,
          file.path,
        );
        // log("Downloaded aya ${aya.numberOfAyaInSurah}");
      } else {
        log("Aya Already downloaded");
      }
    } catch (e) {
      return e;
    }
  }

  Future pauseRadio() async {
    await radioAudioPlayer.pause();
    log("STOOOOOOOOOOOP");
    radioIsPlaying.value = false;
    radioIsLoading.value = false;
    return;
  }

  Future playRadio() async {
    log("TRY TO PLAY");
    try {
      radioAudioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.playing) {
          radioIsPlaying.value = true;
          radioIsLoading.value = false;
        }
        if (playerState.processingState == ProcessingState.loading) {
          radioIsLoading.value = true;
          radioIsPlaying.value = false;
        }
      });
      log("SET URL");
      await radioAudioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            // "https://everyayah.com/data/MaherAlMuaiqly128kbps/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
            "https://Qurango.net/radio/tarateel",
          ),
        ),
      );
      log("SET URL DONE");
      await radioAudioPlayer.play();
      log("PLAY");
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }
}
