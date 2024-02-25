import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/surah_model.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final QuranController _quranController = Get.find<QuranController>();
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  RxInt ayaUniqeId = 1.obs;

  @override
  void onClose() async {
    await audioPlayer.pause();
    _quranController.selectedAyahIndexes.clear();
    super.onClose();
  }

  Future playAyah(AyaOfSurahModel ayaOfSurahModel) async {
    if (isPlaying.value) {
      await audioPlayer.pause();
      audioPlayer = AudioPlayer();
      isPlaying.value = false;
      isLoading.value = false;

      return;
    }
    // ayaUniqeId.value = 0;
    ayaUniqeId.value = ayaOfSurahModel.uniqueIdOfAya;
    try {
      audioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.playing) {
          isPlaying.value = true;
          isLoading.value = false;
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
          log("Complate audio aya id ${ayaUniqeId.value}");
          _quranController.selectedAyahIndexes.clear();

          await playNext(ayaOfSurahModel);
        }
      });
      // final audioSource = LockCachingAudioSource(Uri.parse(
      // "https://cdn.islamic.network/quran/audio/64/ar.saoodshuraym/$ayaUniqeId.mp3"));
      // MaherAlMuaiqly128kbps
      // Abdullaah_3awwaad_Al-Juhaynee_128kbps
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            "https://everyayah.com/data/MaherAlMuaiqly128kbps/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
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
    ayaUniqeId.value++;
    log("Calling play next With id ${ayaUniqeId.value}");
    if (ayaUniqeId <= 6236) {
      try {
        _quranController.selectedAyahIndexes.add(ayaUniqeId.value);
        // MaherAlMuaiqly128kbps
        // Abdullaah_3awwaad_Al-Juhaynee_128kbps
        await audioPlayer.setUrl(
          "https://everyayah.com/data/MaherAlMuaiqly128kbps/${_quranController.getSurahNumberByAya(_quranController.allAyas[ayaUniqeId.value - 1]).toString().padLeft(3, "0")}${_quranController.allAyas[ayaUniqeId.value - 1].numberOfAyaInSurah.toString().padLeft(3, "0")}.mp3",
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
          _quranController.pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceIn);
        }
      } on PlayerInterruptedException catch (e) {
        log('Audio player interrupted: $e');
      }
    }
  }
}
