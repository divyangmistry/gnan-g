import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/model/version.dart';
import 'package:GnanG/utils/app_utils.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class AppSettingUtil {
  static AudioPlayer backgroundMusic;
  static void startBackgroundMusic() {
    AppUtils.appSound(() async {
      if (backgroundMusic == null)
        backgroundMusic = await Flame.audio.loop('music/background_music.mp3', volume: 0.8);
      else
        backgroundMusic.resume();
    });
  }

  static void stopBackgroundMusic() {
    if (backgroundMusic != null) backgroundMusic.pause();
  }

  static String getAppVersion() {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;*/
    return AppConstant.APP_VERSION;
  }

  static String getAppID() {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;*/
    return AppConstant.APP_ID;
  }

}
