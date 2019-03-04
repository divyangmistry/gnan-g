import 'package:GnanG/colors.dart';
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

  static void checkForNewAppUpdate(BuildContext context) {
    String version = AppSetting.getAppVersion();
    Version currentVersion = Version(version: version);
    Version playStoreVersion = Version(version: strPlayStoreVersion);
    if (playStoreVersion.compareTo(currentVersion) > 0) {
      showUpdateDialog(context: context);
    }
  }

  static void showUpdateDialog({
    @required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, right: 2, left: 2),
          shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55.0),
          ),
          title: Center(child: Text("App Update")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "New App Version is avaliable do you want to update now?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, height: 1.5),
                  textScaleFactor: 1.1,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getButton(
                    context: context,
                    text: "Update Now",
                    onPressed: () {
                      AppUtils.launchPlaystoreApp(getAppID());
                    },
                  ),
                  SizedBox(width: 5.0),
                  getButton(context: context, text: "Remind Later", ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getButton(context: context, text: "Cancel"),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static Widget getButton(
      {@required BuildContext context,
      @required String text,
      Function onPressed}) {
    return FlatButton(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      color: kQuizMain500,
      child: Row(
        children: <Widget>[
          Text(
            text,
            textScaleFactor: 1.0,
            style: TextStyle(
              color: kQuizBackgroundWhite,
            ),
          )
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
