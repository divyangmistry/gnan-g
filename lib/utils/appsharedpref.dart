import 'dart:io';
import 'dart:typed_data';

import 'package:GnanG/common.dart';
import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:flutter/material.dart';
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
        ? true
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

  static void saveScore_per_lives(int score_per_lives) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(score_per_lives != null)
      CacheData.score_per_lives = score_per_lives;
    pref.setInt(SharedPrefConstant.i_score_per_lives, score_per_lives);
  }
  static Future<int> getScore_per_lives() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConstant.i_score_per_lives) == null
        ? 20
        : pref.getBool(SharedPrefConstant.i_score_per_lives);
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

  static Future<Image> getProfileImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return CommonFunction.getImageFromBase64Img(base64Img: pref.getString(SharedPrefConstant.s_profileImage));
  }

  static Future<bool> saveAppUpdateCheckAfter(int futureTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(SharedPrefConstant.l_appUpdate_Check_after, futureTime);
    return true;
  }

  static Future<int> getAppUpdateCheckAfter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(SharedPrefConstant.l_appUpdate_Check_after) == null
        ? -1
        : pref.getInt(SharedPrefConstant.l_appUpdate_Check_after);
  }
}
