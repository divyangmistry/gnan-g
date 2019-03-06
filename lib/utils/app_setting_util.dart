import 'package:GnanG/constans/appconstant.dart';
import 'package:package_info/package_info.dart';
class AppSettingUtil {

  static String getAppVersion() {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;*/
    return AppConstant.APP_VERSION;
  }

  static Future<String> getAppID() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appId = packageInfo.packageName;
    return appId;
    //return AppConstant.APP_ID;
  }
}
