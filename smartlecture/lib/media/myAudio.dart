import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyAudio extends ChangeNotifier {
  Duration totalDuration;
  AudioPlayer audioPlayer;
  AudioCache _audioCache;
  Duration position;
  String audioState;
  String url;

  MyAudio() {
    audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: audioPlayer);
    initAudio();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;

      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) audioState = "Stopped";
      if (playerState == PlayerState.PLAYING) audioState = "Playing";
      if (playerState == PlayerState.PAUSED) audioState = "Paused";
      notifyListeners();
    });
  }

  playAudio() async {
    audioPlayer.play(url);
  }

  stopAudio() async {
    int result = await audioPlayer.stop();
  }

  pauseAudio() async {
    int result = await audioPlayer.pause();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}
