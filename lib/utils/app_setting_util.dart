
import 'package:GnanG/utils/app_utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';

class AppSetting {

  static AudioPlayer backgroundMusic;
  static void startBackgroundMusic() {
    AppUtils.appSound(() async {
      if(backgroundMusic == null)
        backgroundMusic = await Flame.audio.loop('music/background_music.mp3', volume: 0.1);
      else
        backgroundMusic.resume();
    });
  }

  static void stopBackgroundMusic() {
      backgroundMusic.pause();
  }
}