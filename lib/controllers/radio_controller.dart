import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/radio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

class RadioController extends GetxController {
  RxBool radioIsPlaying = false.obs;
  RxBool radioIsLoading = false.obs;
  RxInt currentRadioChannelIndex = 0.obs;
  AudioPlayer radioAudioPlayer = AudioPlayer();
  List<RadioModel> radioes = [];

  @override
  onInit() async {
    await loadRadioes();
    super.onInit();
  }

  Future<void> loadRadioes() async {
    String jsonString = await rootBundle.loadString("assets/data/radioes.json");
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> radioesJson = jsonResponse['data'];
    radioes = radioesJson
        .map(
          (e) => RadioModel.fromMap(e),
        )
        .toList();
    update();
  }

  Future pauseRadio() async {
    await radioAudioPlayer.pause();
    radioIsPlaying.value = false;
    radioIsLoading.value = false;
    return;
  }
  Future stopRadio() async {
    await radioAudioPlayer.stop();
    radioIsPlaying.value = false;
    radioIsLoading.value = false;
    return;
  }

  Future<Uri> _loadAssetAsUri(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/jpg');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return file.uri;
  }

  Future playRadio(RadioModel radioModel) async {
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
      await radioAudioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
            radioModel.link,
          ),
          tag: MediaItem(
            id: '1',
            title: radioModel.arabicName,
            displayTitle: S.current.radio,
            displaySubtitle: radioModel.arabicName,
            artUri: await _loadAssetAsUri(kAppIconAsset),
            duration: radioAudioPlayer.duration,
          ),
        ),
      );
      await radioAudioPlayer.play();
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }
}
