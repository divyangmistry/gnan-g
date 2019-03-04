
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/model/version.dart';
import 'package:GnanG/utils/app_utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class AppSetting {

  static AudioPlayer backgroundMusic;
  static  void startBackgroundMusic() {
    AppUtils.appSound(() async {
      if(backgroundMusic == null)
        backgroundMusic = await Flame.audio.loop('music/background_music.mp3', volume: 0.8);
      else
        backgroundMusic.resume();
    });
  }


  static void stopBackgroundMusic() {
    if(backgroundMusic != null)
      backgroundMusic.pause();
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

  static String strPlayStoreVersion = "1.0.1";


  static void checkForNewAppUpdate(BuildContext context) async {
    String version = AppSetting.getAppVersion();
    Version currentVersion  = Version(version: version);
    Version playStoreVersion = Version(version: strPlayStoreVersion);
    if(playStoreVersion.compareTo(currentVersion) > 0) {
      CommonFunction.alertDialog(context: context,
          msg: "New App Version is avalilable, Please Update it",
          doneButtonText: "Update Now",
          doneButtonFn: () {
            AppUtils.launchPlaystoreApp(AppSetting.getAppID());
            Navigator.pop(context);
          }
      );
    }
  }
}