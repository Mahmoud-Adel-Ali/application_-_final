// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/model/reader.dart';

class AudioProvider extends ChangeNotifier {
  // audio player for all application
  AudioPlayer player = AudioPlayer();
  String suraNme = "";
  String currentReader = "";
  bool isPlay = false;
  bool showBottomContainer = false;
  late int idx;
  var currentAudio;

  Duration currentPosition = Duration();
  Duration lengthDuration = Duration();
  playAudio() async {
    await player.play(AssetSource(currentAudio));
  }

  pausePlayer() async {
    await player.pause();
  }

  setUpAudio({required Item item, required int idx}) {
    player.onPositionChanged.listen((event) {
      currentPosition = event;
    });
    player.onDurationChanged.listen((event) {
      lengthDuration = event;
    });
    isPlay = true;
    showBottomContainer = true;
    suraNme = item.name;
    idx = this.idx;
    
  }

  stopAudio() {
    player.stop();
  }

  seekTo(int sec) {
    player.seek(Duration(seconds: sec));
  }
}


