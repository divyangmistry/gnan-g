import 'package:GnanG/constans/appconstant.dart';

class AppSettingUtil {

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
