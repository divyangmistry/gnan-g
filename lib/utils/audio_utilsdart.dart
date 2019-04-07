import 'dart:math';
import 'package:synchronized/synchronized.dart';

import 'package:GnanG/utils/app_utils.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';

class AppAudioUtils {
  static AudioPlayer backgroundMusic;
  static var lock = new Lock();

  static void startBackgroundMusic() async {
    if (!await AppSharedPrefUtil.isMuteEnabled()) {
      await lock.synchronized(() async {
        if (backgroundMusic == null) {
          backgroundMusic =
              await Flame.audio.loop('music/background_music.mp3', volume: 0.2);
        } else
          backgroundMusic.resume();
      });
    };
  }

  static void stopBackgroundMusic() {
    if (backgroundMusic != null) backgroundMusic.pause();
  }

  static void decreaseBackgroundMusic() {
    if (backgroundMusic != null) backgroundMusic.setVolume(0.09);
  }

  static void startOriginalBackgroundMusic() {
    if (backgroundMusic != null) backgroundMusic.setVolume(0.2);
  }

  static Future<AudioPlayer> playMusic({String url, double volume}) async {
    AudioPlayer audioPlayer;
    if (!await AppSharedPrefUtil.isMuteEnabled()) {
      decreaseBackgroundMusic();
      if (volume != null)
        audioPlayer = await Flame.audio.play(url, volume: volume);
      else
        audioPlayer = await Flame.audio.play(url);
      audioPlayer.completionHandler = () {
        startOriginalBackgroundMusic();
      };
    };
    return audioPlayer;
  }

  static void stopMusic(AudioPlayer audioPlayer) {
    if (audioPlayer != null) audioPlayer.stop();
    startOriginalBackgroundMusic();
  }

  static final _random = new Random();
  static int next(int min, int max) => min + _random.nextInt(max - min);
  static AudioPlayer wrongPlayer;
  static void playWrongMusic() async {
    int wrong = next(1, 5);
    String url = "music/wrong/wrong" + wrong.toString() + ".WAV";
    wrongPlayer = await playMusic(url: url);
  }

  static AudioPlayer correctPlayer;
  static void playCorrectMusic() async {
    int correct = next(1, 3);
    String url = "music/right/right" + correct.toString() + ".WAV";
    correctPlayer = await playMusic(url: url);
  }

  static void stopCorrectMusic() async {
    stopMusic(correctPlayer);
  }
}
