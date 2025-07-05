import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/readers_controller.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/reader_model.dart';
import 'package:islamic_app/models/surah_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:islamic_app/controllers/quran_controller.dart';
import 'package:islamic_app/models/aya_of_surah_model.dart';
import 'package:islamic_app/services/last_read_service.dart';
import 'package:islamic_app/services/settings_service.dart';

class AudioController extends GetxController {
  final SettingsService _settingsService = Get.find();
  final LastReadService _lastReadService = Get.find();
  final ReadersController _readersController = Get.find();
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
  ReaderModel get currentReader =>
      _readersController.readers[_settingsService.currentReaderIndex.value];

  String get ayaPath =>
      "${appPath.path}/reader/${currentReader.link}/${currentSura.englishNameOfSurah}/${currentAya.numberOfAyaInSurah}.mp3";

  bool get isInDifferentPage =>
      currentAya.page - 1 != _quranController.pageController.page;

  Future peauseAyaFile() async {
    if (isPlaying.value || isLoading.value) {
      await audioPlayer.pause();
      _quranController.clearSelection();
      isPlaying.value = false;
      isLoading.value = false;
      return;
    }
  }

  Future stopAudioPlayer() async {
    await audioPlayer.stop();
    _quranController.clearSelection();
    isPlaying.value = false;
    isLoading.value = false;
    return;
  }

  Future initAudioPlayerStateStream() async {
    audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.playing) {
        isPlaying.value = true;
        isLoading.value = false;
        duration.value = audioPlayer.duration ?? Duration.zero;
        audioPlayer.positionStream.listen((position) {
          currentDuration.value = position;
          duration.value = audioPlayer.duration ?? Duration.zero;
        });
      }

      if (playerState.processingState == ProcessingState.loading) {
        isLoading.value = true;
        isPlaying.value = false;
      }
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying.value = false;
        _quranController.selectedAyahIndexes.clear();
        if (ayaUniqeId.value == 6236) {
          return;
        }
        ayaUniqeId.value = ayaUniqeId.value + 1;
        await playAyah(currentAya);
      }
    });
    audioPlayer.positionStream.listen((position) {
      currentDuration.value = position;
    });
  }

  Future playAyah(AyaOfSurahModel aya) async {
    ayaUniqeId.value = aya.uniqueIdOfAya;
    if (ayaUniqeId.value >= 0 && ayaUniqeId.value <= 6236) {
      File file = File(ayaPath);
      if (await file.exists()) {
        log("aya already downloaded and it will play");
        await playAyaFile(file);
      } else {
        Get.find<ReadersController>().cancelToken = CancelToken();
        log("aya doesnt been downloaded and it will download");
        isLoading.value = true;
        await _readersController.downloadAya(
          file,
          aya,
          _quranController
              .surahs[_quranController.getSurahNumberByAya(aya) - 1],
          currentReader,
        );
        await Future.delayed(const Duration(milliseconds: 900));
        await playAyaFile(file);
      }
    }
  }

  Future<Uri> _loadAssetAsUri(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}.jpg');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return file.uri;
  }

  Future playAyaFile(File ayaFile) async {
    try {
      _quranController.clearSelection();
      _quranController.selectedAyahIndexes.add(currentAya.uniqueIdOfAya);
      await audioPlayer.setAudioSource(
        AudioSource.file(ayaFile.path,
            tag: MediaItem(
              id: currentAya.uniqueIdOfAya.toString(),
              title: Get.locale.toString() == "en"
                  ? currentSura.englishNameOfSurah
                  : currentSura.nameOfSurah,
              displayTitle: Get.locale.toString() == "en"
                  ? "${currentSura.englishNameOfSurah} | ${S.current.aya}-${currentAya.numberOfAyaInSurah}"
                  : "${currentSura.nameOfSurah} | ${S.current.aya}-${currentAya.numberOfAyaInSurah}",
              artist: Get.locale.toString() == "en"
                  ? _readersController.currentReader.englishName
                  : _readersController.currentReader.arabicName,
              duration: duration.value,
              artUri:
                  await _loadAssetAsUri(_readersController.currentReader.image),
            )),
      );
      duration.value = audioPlayer.duration ?? Duration.zero;
      if (isInDifferentPage) {
        _quranController.pageController.animateToPage(
          currentAya.page - 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
      }
      await audioPlayer.play();
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }
}
