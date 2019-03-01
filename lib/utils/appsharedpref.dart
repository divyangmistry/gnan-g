import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppSharedPrefUtil {
  /*SharedPreferences pref;
  static final AppSharedPrefUtil _singleton = new AppSharedPrefUtil._internal();

  factory AppSharedPrefUtil() {
    SharedPreferences.getInstance().then((onValue) => this.pref = onValue);
    return _singleton;
  }

  AppSharedPrefUtil._internal();*/

  static Future<bool> isMuteEnabled() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConstant.b_muteSound) == null
        ? false
        : pref.getBool(SharedPrefConstant.b_muteSound);
  }

  static void saveMuteEnabled(bool isMuteEnabled) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefConstant.b_muteSound, isMuteEnabled);
  }
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConstant.b_isUserLoggedIn) == null
        ? false
        : pref.getBool(SharedPrefConstant.b_isUserLoggedIn);
  }

  static Future<UserInfo> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(json.decode(pref.getString('user_info'))['data']);
    return UserInfo.fromJson(json.decode(pref.getString('user_info'))['data']);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }


}
