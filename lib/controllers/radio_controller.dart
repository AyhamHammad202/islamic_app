import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/radio_model.dart';
import 'package:just_audio/just_audio.dart';

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
        ),
      );
      // AwesomeNotifications().createNotification(
      //   content: NotificationContent(
      //     notificationLayout: NotificationLayout.MediaPlayer,
      //     id: 10,
      //     channelKey: 'progress_bar',
      //     title: radioModel.arabicName,
      //     locked: radioIsPlaying.value,
      //   ),
      // );
      await radioAudioPlayer.play();
    } on PlayerInterruptedException catch (e) {
      log('Audio player interrupted: $e');
    }
  }
}
