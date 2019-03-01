import 'package:GnanG/utils/appsharedpref.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flame/flame.dart';

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
}
