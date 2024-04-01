import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/services/settings_service.dart';
import 'package:just_audio/just_audio.dart';

import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:path_provider/path_provider.dart';

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
  void onInit() {
    ayaUniqeId.value = _lastReadService.lastAyaUniqeNumRead.value;
    super.onInit();
  }

  Future playAyah(AyaOfSurahModel ayaOfSurahModel) async {
    // ayaUniqeId.value = 0;
    ayaUniqeId.value = _lastReadService.lastAyaUniqeNumRead.value;
    ayaUniqeId.value = ayaOfSurahModel.uniqueIdOfAya;
    try {
      if (isPlaying.value || isLoading.value) {
        await audioPlayer.pause();
        _quranController.clearSelection();
        audioPlayer = AudioPlayer();
        isPlaying.value = false;
        isLoading.value = false;

        return;
      }
      _quranController.clearSelection();
      _quranController.selectedAyahIndexes.add(ayaUniqeId.value);
      audioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.playing) {
          isPlaying.value = true;
          isLoading.value = false;
          duration.value = audioPlayer.duration ?? Duration.zero;
          audioPlayer.positionStream.listen((position) {
            currentDuration.value = position;
            // log("message $position");
          });
        }

        if (playerState.processingState == ProcessingState.loading) {
          isLoading.value = true;
          isPlaying.value = false;
        }
        // if (playerState.processingState == ProcessingState.ready) {
        //   await audioPlayer.play();
        //   isLoading.value = false;
        //   isPlaying.value = true;
        // }

        if (playerState.processingState == ProcessingState.completed) {
          isPlaying.value = false;
          _quranController.selectedAyahIndexes.clear();
          ayaUniqeId.value++;

          await playNext(ayaOfSurahModel);
        }
      });
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            "https://everyayah.com/data/${Constant.readersLinks[_settingsService.currentReaderIndex.value]}/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
          ),
        ),
      );
      // await audioPlayer.setAudioSource(audioSource);
      await audioPlayer.play();
      // time.value = "0";
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }

  Future playNext(AyaOfSurahModel aya) async {
    log("Calling play next With id ${ayaUniqeId.value}");
    if (ayaUniqeId <= 6236) {
      try {
        _quranController.clearSelection();
        _quranController.selectedAyahIndexes.add(ayaUniqeId.value);
        // MaherAlMuaiqly128kbps
        // Abdullaah_3awwaad_Al-Juhaynee_128kbps
        await audioPlayer.setUrl(
          "https://everyayah.com/data/${Constant.readersLinks[_settingsService.currentReaderIndex.value]}/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
        );

        await audioPlayer.play();
        if (_quranController.allAyas[ayaUniqeId.value - 1].page !=
            _quranController.allAyas[ayaUniqeId.value - 2].page) {
          log("Playing Aya in ANother Page");
          Get.showSnackbar(
            const GetSnackBar(
              title: "Playing Aya in ANother Page",
              message: "تشغيل اية في الصفحة التالية",
              duration: Duration(seconds: 1),
            ),
          );
          _quranController.pageController.animateToPage(
            _quranController.allAyas[ayaUniqeId.value - 1].page,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceIn,
          );
        }
      } on PlayerInterruptedException catch (e) {
        log('Audio player interrupted: $e');
      }
    }
  }

  Future playBack() async {
    log("Calling play next With id ${ayaUniqeId.value}");
    if (ayaUniqeId <= 6236 && ayaUniqeId.value > 1) {
      ayaUniqeId.value--;
      try {
        _quranController.clearSelection();
        _quranController.selectedAyahIndexes.add(ayaUniqeId.value);
        // MaherAlMuaiqly128kbps
        // Abdullaah_3awwaad_Al-Juhaynee_128kbps
        await audioPlayer.setUrl(
          "https://everyayah.com/data/${Constant.readersLinks[_settingsService.currentReaderIndex.value]}/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
        );

        await audioPlayer.play();
        if (_quranController.allAyas[ayaUniqeId.value - 1].page !=
            _quranController.allAyas[ayaUniqeId.value].page) {
          log("Playing Aya in ANother Page");
          Get.showSnackbar(
            const GetSnackBar(
              title: "Playing Aya in ANother Page",
              message: "تشغيل اية في الصفحة التالية",
              duration: Duration(seconds: 1),
            ),
          );
          _quranController.pageController.animateToPage(
            _quranController.allAyas[ayaUniqeId.value - 1].page,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceIn,
          );
        }
      } on PlayerInterruptedException catch (e) {
        log('Audio player interrupted: $e');
      }
    }
  }

  Future<bool> isAyaDownloaded(aya) async {
    var appPath = await getApplicationDocumentsDirectory();
    var fullPath =
        "${appPath.path}/reader${_quranController.surahs[_quranController.getSurahNumberByAya(aya) - 1].englishNameOfSurah}/${aya.numberOfAyaInSurah}";
    File file = File(fullPath);
    return file.exists();
  }

  Future downloadAya(AyaOfSurahModel aya) async {
    try {
      var appPath = await getApplicationDocumentsDirectory();
      var fullPath =
          "${appPath.path}/reader${_quranController.surahs[_quranController.getSurahNumberByAya(aya) - 1].englishNameOfSurah}/${aya.numberOfAyaInSurah}";
      File file = File(fullPath);
      if (!await file.exists()) {
        log("Download aya ${aya.numberOfAyaInSurah}");
        var donwloadUrl =
            "https://everyayah.com/data/${Constant.readersLinks[_settingsService.currentReaderIndex.value]}/${_quranController.getSurahNumberByAya(aya).toString().padLeft(3, "0")}${aya.numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3";

        await dio.download(
          donwloadUrl,
          fullPath,
        );
      } else {
        log("Aya Already downloaded");
        await audioPlayer.setFilePath(fullPath);
        await audioPlayer.play();
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
