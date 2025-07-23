import 'dart:developer' show log;

import 'package:audio_service/audio_service.dart';
import 'package:islamic_app/controllers/audio_controller.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  static final AudioPlayerHandler _instance = AudioPlayerHandler._internal();
  static AudioPlayerHandler get instance => _instance;

  final audioCtrl = AudioController.instance;

  // final audioHandler = AudioService();

  AudioPlayerHandler._internal() {
    // الاستماع لتغيرات حالة التشغيل
    audioCtrl.audioPlayer.playbackEventStream
        .map(_transformEvent)
        .pipe(playbackState);

    // إضافة العنصر الصوتي الأولي
    mediaItem.add(audioCtrl.mediaItem);

    // تحديث mediaItem عند تغيير السورة من داخل اللاعب
    // surahCtrl.audioPlayer.currentIndexStream.listen((index) {
    //   if (index != null && index >= 0 && index < 114) {
    //     surahCtrl.surahNum.value = index + 1;
    //     final newMediaItem = surahCtrl.mediaItem;
    //     mediaItem.add(newMediaItem);
    //   }
    // });
  }

  @override
  Future<void> play() async {
    log('Surah is playing');
    audioCtrl.isPlaying.value = true;
    await audioCtrl.audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    log('Surah is paused');
    audioCtrl.isPlaying.value = false;
    await audioCtrl.audioPlayer.pause();
  }

  @override
  Future<void> skipToNext() async {
    if (audioCtrl.ayaUniqeId.value >= 6236) return;
    await audioCtrl.peauseAyaFile();
    audioCtrl.ayaUniqeId.value++;
    await audioCtrl.playAyah(audioCtrl.currentAya);
  }

  @override
  Future<void> skipToPrevious() async {
    if (audioCtrl.ayaUniqeId.value <= 1) return;
    await audioCtrl.peauseAyaFile();
    audioCtrl.ayaUniqeId.value--;
    await audioCtrl.playAyah(audioCtrl.currentAya);
  }

  @override
  Future<void> seek(Duration position) => audioCtrl.audioPlayer.seek(position);

  @override
  Future<void> stop() async {
    await audioCtrl.audioPlayer.stop();
  }

  /// تحويل حدث just_audio إلى حالة audio_service
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (audioCtrl.audioPlayer.playing)
          MediaControl.pause
        else
          MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioCtrl.audioPlayer.processingState]!,
      playing: audioCtrl.audioPlayer.playing,
      updatePosition: audioCtrl.audioPlayer.position,
      bufferedPosition: audioCtrl.audioPlayer.bufferedPosition,
      speed: audioCtrl.audioPlayer.speed,
      queueIndex: event.currentIndex,
    );
  }
}
