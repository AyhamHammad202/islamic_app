import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class audioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
}
