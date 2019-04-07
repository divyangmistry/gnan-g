import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/utils/app_setting_util.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:launch_review/launch_review.dart';

import 'dart:io' show Platform;

class AppUtils {
  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else
      return true;
  }

  static void registrerConnectivityChange() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.none) {
        print(' ------> inside NO internet ! <------');
      }
    });
  }

  static void playAudio(String audioPath) async {
    if (!await AppSharedPrefUtil.isMuteEnabled()) {
      Flame.audio.play(audioPath);
    }
  }

  static void appSound(Function playAudio) async {
    if (!await AppSharedPrefUtil.isMuteEnabled()) {
      playAudio();
    }
  }

  static launchStoreApp() {
    return Platform.isIOS ? launchAppstoreApp() : launchPlaystoreApp();
  }

  static void launchPlaystoreApp() async {
    String appId = await AppSettingUtil.getAppID();
    launch(AppConstant.BASE_PLAYSTORE_URL + appId);
    /*LaunchReview.launch(androidAppId: "org.dadabhagwan.AKonnect",
        iOSAppId: "585027354");*/
  }

  static void launchAppstoreApp() async {
    String appId = await AppSettingUtil.getAppID();
    launch(AppConstant.BASE_APPSTORE_URL);
    /*LaunchReview.launch(androidAppId: "org.dadabhagwan.AKonnect",
        iOSAppId: "585027354");*/
  }

  static void showInSnackBar(BuildContext context, String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
}
