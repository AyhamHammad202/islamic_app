import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_library/quran.dart';

import '/controllers/quran_controller.dart';
import '/controllers/readers_controller.dart';
import '/generated/l10n.dart';
import '/models/reader_model.dart';
import '/services/last_read_service.dart';
import '/services/settings_service.dart';
import 'audio_player_handler.dart';

class AudioController extends GetxController {
  static AudioController get instance =>
      GetInstance().putOrFind(() => AudioController());

  final SettingsService _settingsService = Get.find();
  final LastReadService _lastReadService = Get.find();
  final ReadersController _readersController = Get.find();
  final QuranController _quranController = Get.find<QuranController>();

  final AudioPlayer audioPlayer = AudioPlayer();
  final Dio dio = Dio();

  late final Directory appPath;

  // Reactive variables
  final RxBool isPlaying = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isDownloading = false.obs;
  final RxDouble downloadingProgress = 0.0.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> currentDuration = Duration.zero.obs;
  final RxInt ayaUniqeId = 1.obs;
  late Directory dir;
  Uri? cachedArtUri; // تحويل إلى متغير اختياري - Make variable optional

  // Getters
  AyahModel get currentAya => _quranController.ayas[ayaUniqeId.value - 1];
  SurahModel get currentSura =>
      QuranLibrary().getCurrentSurahDataByAyah(ayah: currentAya);
  ReaderModel get currentReader =>
      _readersController.readers[_settingsService.currentReaderIndex.value];
  String get ayaPath =>
      "${appPath.path}/reader/${currentReader.link}/${currentSura.englishName}/${currentAya.ayahNumber}.mp3";
  bool get isInDifferentPage =>
      currentAya.page != QuranLibrary().currentPageNumber;

  // Lifecycle
  @override
  Future<void> onInit() async {
    // تهيئة ayaUniqeId - Initialize ayaUniqeId
    ayaUniqeId.value = _lastReadService.lastAyaUniqeNumRead.value;

    // تهيئة appPath - Initialize appPath
    appPath = await getApplicationDocumentsDirectory();

    // تهيئة Audio Player streams - Initialize Audio Player streams
    await _initAudioPlayerStreams();

    // انتظار تحميل الموارد المطلوبة - Wait for required resources to load
    await Future.wait([
      getCachedArtUri().then((v) => cachedArtUri = v),
      getApplicationDocumentsDirectory().then((v) => dir = v),
    ]);

    // تهيئة خدمة الصوت بعد تحميل cachedArtUri - Initialize audio service after cachedArtUri is loaded
    await initAudioService();

    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await audioPlayer.pause();
    _clearSelection();
    super.onClose();
  }

  // Core functionality
  Future<void> playAyah(AyahModel aya) async {
    ayaUniqeId.value = aya.ayahUQNumber;
    if (ayaUniqeId.value < 1 || ayaUniqeId.value > 6236) return;

    final file = File(ayaPath);
    if (await file.exists()) {
      log("Ayah already downloaded. Playing...");
      await _playAyaFile(file);
    } else {
      log("Downloading Ayah...");
      isLoading.value = true;
      await _readersController.downloadAya(
        file,
        aya,
        currentSura,
        currentReader,
      );
      await Future.delayed(const Duration(milliseconds: 900));
      await _playAyaFile(file);
    }
  }

  Future<void> peauseAyaFile() async {
    if (isPlaying.value || isLoading.value) {
      await audioPlayer.pause();
      _clearSelection();
      isPlaying.value = false;
      isLoading.value = false;
    }
  }

  Future<void> stopAudioPlayer() async {
    await audioPlayer.stop();
    _clearSelection();
    isPlaying.value = false;
    isLoading.value = false;
  }

  // Internal logic
  Future<void> _initAudioPlayerStreams() async {
    audioPlayer.playerStateStream.listen(_handlePlayerState);
    audioPlayer.positionStream.listen((position) {
      currentDuration.value = position;
    });
  }

  void _handlePlayerState(PlayerState state) async {
    switch (state.processingState) {
      case ProcessingState.loading:
        isLoading.value = true;
        isPlaying.value = false;
        break;
      case ProcessingState.completed:
        await _onAyahComplete();
        break;
      default:
        if (state.playing) {
          isPlaying.value = true;
          isLoading.value = false;
          duration.value = audioPlayer.duration ?? Duration.zero;
        }
        break;
    }
  }

  Future<void> _onAyahComplete() async {
    isPlaying.value = false;
    _clearSelection();
    if (ayaUniqeId.value < 6236) {
      ayaUniqeId.value++;
      await playAyah(currentAya);
    }
  }

  Future<void> _playAyaFile(File ayaFile) async {
    try {
      _clearSelection();
      QuranLibrary().quranCtrl.toggleAyahSelection(currentAya.ayahUQNumber);

      await audioPlayer.setAudioSource(
        AudioSource.file(
          ayaFile.path,
          tag: mediaItem,
        ),
      );

      duration.value = audioPlayer.duration ?? Duration.zero;

      if (isInDifferentPage) {
        QuranLibrary().quranCtrl.pageController.animateToPage(
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

  Future<Uri> _loadAssetAsUri(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}.jpg');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return file.uri;
  }

  // Helper methods
  void _clearSelection() {
    QuranLibrary().quranCtrl.clearSelection();
  }

  String _getLocalizedSuraName() {
    return Get.locale.toString() == "en"
        ? currentSura.englishName
        : currentSura.arabicName;
  }

  String _getLocalizedReaderName() {
    return Get.locale.toString() == "en"
        ? currentReader.englishName
        : currentReader.arabicName;
  }

  Future<void> initAudioService() async {
    await AudioService.init(
      builder: () => AudioPlayerHandler.instance,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.NourAlmomen.islamicapp.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
  }

  Future<Uri> getCachedArtUri() async {
    final file = await DefaultCacheManager().getSingleFile(
        'https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/Photos/ios-1024.png');
    return await file.exists()
        ? file.uri
        : Uri.parse(
            'https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/Photos/ios-1024.png');
  }

  MediaItem get mediaItem => MediaItem(
        id: currentAya.ayahUQNumber.toString(),
        title: _getLocalizedSuraName(),
        displayTitle:
            "${_getLocalizedSuraName()} | ${S.current.aya}-${currentAya.ayahNumber}",
        artist: _getLocalizedReaderName(),
        duration: duration.value,
        // استخدام قيمة افتراضية إذا لم يتم تحميل cachedArtUri - Use default value if cachedArtUri not loaded
        artUri: cachedArtUri ??
            Uri.parse(
                'https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/Photos/ios-1024.png'),
      );
}
