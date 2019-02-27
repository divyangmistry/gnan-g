import 'package:connectivity/connectivity.dart';

class AppUtils {

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
        return false;
    }
    else
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
}