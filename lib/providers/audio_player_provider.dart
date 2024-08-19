import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isPaused = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  AudioPlayerProvider() {
    _audioPlayer.positionStream.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((newDuration) {
      duration = newDuration ?? Duration.zero;
      notifyListeners();
    });
  }

  Future<void> play(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      isPlaying = true;
      isPaused = false;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  void pause() {
    _audioPlayer.pause();
    isPlaying = false;
    isPaused = true;
    notifyListeners();
  }

  void stop() {
    _audioPlayer.stop();
    isPlaying = false;
    isPaused = false;
    position = Duration.zero;
    notifyListeners();
  }

  void disposePlayer() {
    _audioPlayer.dispose();
  }
}
